class RadarMapController < UIViewController
  include MapKit
  include CoreLocation
  TIME_TO_REFRESH_RADARS = 60 * 5 # 5 minutes in seconds for refreshing all radars positions
  def init
    if super
    end
    self
  end

  def loadView
    self.view = UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    self.view.backgroundColor = UIColor.whiteColor
    BW::Location.get(purpose: 'Precisamos de usar o seu GPS!') do |result|
      
    end
    self.view = MapView.new
    view.delegate = self

  end
  
  def viewDidLoad
    view.frame = self.view.bounds
    view.zoom_enabled = true
    view.shows_user_location = true
    update_map
  end

  def add_annotations(radars)
    radars.each_with_index do |r, i|
    center = CLLocationCoordinate2DMake(*r.point_coordinate)
    annotationPoint = MKPointAnnotation.alloc.init
    annotationPoint.coordinate = center
    view.addAnnotation(annotationPoint)
    end
  end

  private 

  def update_map
    @update_at = nil
    @radars = []
    add_annotations(@radars)  
    BW::Location.get(distance_filter: 100, desired_accuracy: :best_for_navigation) do |result|
      if @update_at.nil?
       # First time, update radars
        AFMotion::JSON.get('http://radares.realfevr.com/radars.json') do |result| 
          @update_at = Time.now.to_i
          if result.success?
            json = BW::JSON.parse(result.body)
            @radars = Radar.initializeRadarsFromJson(json)
            add_annotations(@radars)
          end
        end
      
      elsif @update_at > Time.now.to_i - TIME_TO_REFRESH_RADARS
      # DO NOTHING JUST IN THIS CONDITION
      else
        # Remove pins and update radars again
        AFMotion::JSON.get('http://radares.realfevr.com/radars.json') do |result| 
          @update_at = Time.now.to_i
          if result.success?
            json = BW::JSON.parse(result.body)
            @radars = Radar.initializeRadarsFromJson(json)
            view.removeAnnotations(view.annotations)
            add_annotations(@radars)
          end
        end
      end
      # Ensure that device return a coordinate
      if result[:to] && result[:to].latitude && result[:to].longitude
        latitude = result[:to].latitude
        longitude =  result[:to].longitude
        self.view.region = CoordinateRegion.new([latitude, longitude], [0.1, 0.1])
        user_position = CLLocationCoordinate2D.new(latitude, longitude)
        trigger = AlertsManager.check_position(user_position, @radars)
      end
    end
  end
end