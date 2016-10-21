
function line(poiData){
    this.poiData = poiData;
    var lineLocation = new AR.GeoLocation(poiData.latitude, poiData.longitude, poiData.altitude);
    this.lineDrawable_idle = new AR.ImageDrawable(new AR.ImageResource("assets/indi.png"), 2, {
                                                    zOrder: 0,
                                                    opacity: 0.6,
                                                  rotate:{tilt:70}
                                                    });
    this.lineObject = new AR.GeoObject(lineLocation, {
                                         drawables: {
                                         cam: [this.lineDrawable_idle]
                                         }
                                         });
    
    return this;
}