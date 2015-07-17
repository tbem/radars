class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    radarMapController = RadarMapController.alloc.init
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = radarMapController
    @window.makeKeyAndVisible
    true
  end

end
