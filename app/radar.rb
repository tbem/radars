class Radar

  attr_reader :description, :coordinate, :region
  attr_accessor :appeared_time

  def initialize(lat, long, description)
    @description = description
    @coordinate = CLLocationCoordinate2D.new(lat, long)
    @region = CLCircularRegion.alloc.initWithCenter(@coordinate, radius: 1500.0, identifier: "Mycirc#{self.object_id}")
    
    @appeared_time = 0
  end

  def point_coordinate
    [ @coordinate.latitude, @coordinate.longitude ] 
  end

  def alert
    if (Time.now.to_i - (5 * 60)) > self.appeared_time 
        self.appeared_time = Time.now.to_i
        alert_box
    end
  end

  def self.initializeRadarsFromJson(json)
    json.map do |radar|
      self.new(radar['latitude'], radar['longitude'], radar['description'] )
    end
  end

  private 

  def alert_box
    @alert_box = 
    UIAlertView.alloc.initWithTitle(
      "Radar ZONE!!!",
      message: self.description,
      delegate: nil,
      cancelButtonTitle: "I got it!",
      otherButtonTitles:nil
    )
    @alert_box.show
  end
end