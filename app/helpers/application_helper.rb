# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def show_kitas_map
    lats = []
    lngs = []
    @kita_map = GMap.new("Map")
    @kita_map.control_init(:small_map => true, :map_type => true)
    my_loc_icon = GIcon.new(:image => "/images/arrow.png",
       :shadow => "/images/arrowshadow.png",
       :shadow_size => GSize.new(39,34),
       :icon_anchor => GPoint.new(12,34))
    @kita_map.overlay_init(GMarker.new([@my_loc.lat, @my_loc.lng], :title => "Ihr Standort", :icon => my_loc_icon))
    lats << @my_loc.lat
    lngs << @my_loc.lng
    @kitas.each do |kita|
      lats << kita.lat
      lngs << kita.lng
      @kita_map.overlay_init(kita.map_marker)
    end
    avg_lat = (lats.inject(0) {|sum,item| sum + item}) / lats.size
    avg_lng = (lngs.inject(0) {|sum,item| sum + item}) / lngs.size
    @kita_map.center_zoom_init([avg_lat, avg_lng], 13)
  end
  
end
