class AlertsManager
 
  def self.check_position(position, radars)
    radars.each do |radar|
      if radar.region.containsCoordinate(position) 
        radar.alert
      end
    end
  end
  
end