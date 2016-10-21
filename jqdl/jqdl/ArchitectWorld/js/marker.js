//var kMarker_AnimationDuration_ChangeDrawable = 500;
//var kMarker_AnimationDuration_Resize = 1000;

function Marker(poiData) {

    this.poiData = poiData;
    this.isSelected = false;

    /*
        With AR.PropertyAnimations you are able to animate almost any property of ARchitect objects. This sample will animate the opacity of both background drawables so that one will fade out while the other one fades in. The scaling is animated too. The marker size changes over time so the labels need to be animated too in order to keep them relative to the background drawable. AR.AnimationGroups are used to synchronize all animations in parallel or sequentially.
    */

//    this.animationGroup_idle = null;
//    this.animationGroup_selected = null;


    // create the AR.GeoLocation from the poi data
    
    
    var markerLocation = new AR.GeoLocation(poiData.latitude, poiData.longitude, poiData.altitude);

    // create an AR.ImageDrawable for the marker in idle state
    this.markerDrawable_idle = new AR.ImageDrawable(World.markerDrawable_idle, 2.5, {
        zOrder: 0,
        opacity: 0.6,
                                                    
        /*
            To react on user interaction, an onClick property can be set for each AR.Drawable. The property is a function which will be called each time the user taps on the drawable. The function called on each tap is returned from the following helper function defined in marker.js. The function returns a function which checks the selected state with the help of the variable isSelected and executes the appropriate function. The clicked marker is passed as an argument.
        */
        onClick: Marker.prototype.getOnClickTrigger(this)
    });

    // create an AR.ImageDrawable for the marker in selected state
    this.markerDrawable_selected = new AR.ImageDrawable(World.markerDrawable_selected, 2.5, {
        zOrder: 0.9,
        opacity: 0.0,
        onClick: null
    });
    
    //添加左侧图标
    this.leftImage = new AR.ImageDrawable(new AR.ImageResource("assets/marker_type1.png"), 2.2, {
                                          zOrder: 1,
                                          opacity: 1.0,
                                          offsetX:-3.3
                                          });
    
//    //添加底部详情图片
//    var imageres = new AR.ImageResource("http://cdn0.hbimg.cn/store/snsthumbs/160_160/album/201202/8079D7B4EBAD9BB081F0CBCE4BAE84FFCA8021F2FD.jpg");
//    this.detailImage = new AR.ImageDrawable(imageres, 5 , {
//                                            zOrder:0,
//                                            opacity:0.0,
//                                            offsetY:-4,
//                                            onClick:function(){
//                                                World.onDetailImageSelected(this);
//                                            
//                                            }
//                                            });
    
    
    var _html="<div class='zdyDemo' style='height:600px;font-size:5em;border-radius:0.3em;background:#fff;position:relative'>";
    _html+="<img src='http://img.qlxing.com/0a131bec-408a-404f-825f-3f9b959204dd' style='width:100%;height:600px;border-radius:0.3em'/>";
    _html+="<span style='position:absolute;height:1.5em;bottom:0px;background:rgba(0,0,0,0.6);z-index:100;display:block;width:100%;color:#fff;line-height:1.5em;padding-left:0.4em;font-size:0.6em;border-radius:0 0 0.5em 0.5em;'>武胜西街13-432号--距离:</span>";
    _html+="<span style='position:absolute;height:1em;bottom:0.5em;width:100%;display:block;z-index:120;padding-left:0.2em;'><img src='https://wap.qlxing.com/images/activity/startOne.png'/><img src='https://wap.qlxing.com/images/activity/startOne.png'/><img src='https://wap.qlxing.com/images/activity/startOne.png'/><img src='https://wap.qlxing.com/images/activity/startOne.png'/><img src='https://wap.qlxing.com/images/activity/startOne.png'/></span>";
    _html+="</div>";
    
    this.htmlDrawable = new AR.HtmlDrawable({html:_html}, 9,
        {
            offsetY:-6.2,
            zOrder:1,
            horizontalAnchor : AR.CONST.HORIZONTAL_ANCHOR.CENTER,
            opacity : 0.0,
            enabled : false,
            onClick : function(){
                                            
                World.isClickDetailImage = true;
                                            
                AR.logger.debug(World.currentMarker.poiData.id + " getOnHtmlClickTrigger");
                                            
                var currentMarker = World.currentMarker;
                var architectSdkUrl = "architectsdk://markerselected?id=" + encodeURIComponent(currentMarker.poiData.id) + "&title=" + encodeURIComponent(currentMarker.poiData.title) + "&description=" + encodeURIComponent(currentMarker.poiData.description);
                /*
                 The urlListener of the native project intercepts this call and parses the arguments.
                 This is the only way to pass information from JavaSCript to your native code.
                 Ensure to properly encode and decode arguments.
                 Note: you must use 'document.location = "architectsdk://...' to pass information from JavaScript to native.
                 ! This will cause an HTTP error if you didn't register a urlListener in native architectView !
                 */
                document.location = architectSdkUrl;
            }
       });
    
    

    // create an AR.Label for the marker's title 
    this.titleLabel = new AR.Label(poiData.title, 1, {
        zOrder: 1,
        offsetX:-2,
        offsetY: 0.55,
        horizontalAnchor: AR.CONST.HORIZONTAL_ANCHOR.LEFT,
        style: {
            textColor: '#FFFFFF',
            fontStyle: AR.CONST.FONT_STYLE.BOLD
        }
    });

    // create an AR.Label for the marker's description
    this.descriptionLabel = new AR.Label(poiData.description.trunc(20), 0.8, {
        zOrder: 1,
        offsetX:-2,
        offsetY: -0.55,
        horizontalAnchor: AR.CONST.HORIZONTAL_ANCHOR.LEFT,
        style: {
            textColor: '#FFFFFF'
        }
    });

    /*
        Create an AR.ImageDrawable using the AR.ImageResource for the direction indicator which was created in the World. Set options regarding the offset and anchor of the image so that it will be displayed correctly on the edge of the screen.
    */
    this.directionIndicatorDrawable = new AR.ImageDrawable(World.markerDrawable_directionIndicator, 0.1, {
        enabled: false,
        verticalAnchor: AR.CONST.VERTICAL_ANCHOR.TOP
    });

    this.radarCircle = new AR.Circle(0.03, {
        horizontalAnchor: AR.CONST.HORIZONTAL_ANCHOR.CENTER,
        opacity: 0.8,
        style: {
            fillColor: "#ffffff"
        }
    });

    this.radarCircleSelected = new AR.Circle(0.05, {
        horizontalAnchor: AR.CONST.HORIZONTAL_ANCHOR.CENTER,
        opacity: 0.8,
        style: {
            fillColor: "#0066ff"
        }
    });

    this.radardrawables = [];
    this.radardrawables.push(this.radarCircle);

    this.radardrawablesSelected = [];
    this.radardrawablesSelected.push(this.radarCircleSelected);

    /*  
        Note that indicator and radar-drawables were added
    */
    this.markerObject = new AR.GeoObject(markerLocation, {
        drawables: {
            cam: [this.markerDrawable_idle, this.markerDrawable_selected, this.leftImage, this.titleLabel, this.descriptionLabel, this.htmlDrawable],
            indicator: this.directionIndicatorDrawable,
            radar: this.radardrawables
        }
    });

    return this;
}

Marker.prototype.getOnClickTrigger = function(marker) {
    
    /*
        The setSelected and setDeselected functions are prototype Marker functions. 
        Both functions perform the same steps but inverted.
    */

    return function() {

//        if (!Marker.prototype.isAnyAnimationRunning(marker)) {
            if (marker.isSelected) {

                Marker.prototype.setDeselected(marker);

            } else {
                Marker.prototype.setSelected(marker);
                try {
                    World.onMarkerSelected(marker);
                } catch (err) {
                    alert(err);
                }

            }
//        } else {
//            AR.logger.debug('a animation is already running');
//        }


        return true;
    };
};

/*
    Property Animations allow constant changes to a numeric value/property of an object, dependent on start-value, end-value and the duration of the animation. Animations can be seen as functions defining the progress of the change on the value. The Animation can be parametrized via easing curves.
*/

Marker.prototype.setSelected = function(marker) {
    AR.logger.debug(marker.poiData.id + " setSelected");
    marker.isSelected = true;

//    if (marker.animationGroup_selected === null) {
//
//        // create AR.PropertyAnimation that animates the opacity to 0.0 in order to hide the idle-state-drawable
//        var hideIdleDrawableAnimation = new AR.PropertyAnimation(marker.markerDrawable_idle, "opacity", null, 0.0, kMarker_AnimationDuration_ChangeDrawable);
//        // create AR.PropertyAnimation that animates the opacity to 1.0 in order to show the selected-state-drawable
//        var showSelectedDrawableAnimation = new AR.PropertyAnimation(marker.markerDrawable_selected, "opacity", null, 1.0, kMarker_AnimationDuration_ChangeDrawable);
//
////        // create AR.PropertyAnimation that animates the scaling of the idle-state-drawable to 1.2
////        var idleDrawableResizeAnimation = new AR.PropertyAnimation(marker.markerDrawable_idle, 'scaling', null, 1.0, kMarker_AnimationDuration_Resize, new AR.EasingCurve(AR.CONST.EASING_CURVE_TYPE.EASE_OUT_ELASTIC, {
////            amplitude: 2.0
////        }));
////        // create AR.PropertyAnimation that animates the scaling of the selected-state-drawable to 1.2
////        var selectedDrawableResizeAnimation = new AR.PropertyAnimation(marker.markerDrawable_selected, 'scaling', null, 1.0, kMarker_AnimationDuration_Resize, new AR.EasingCurve(AR.CONST.EASING_CURVE_TYPE.EASE_OUT_ELASTIC, {
////            amplitude: 2.0
////        }));
////        // create AR.PropertyAnimation that animates the scaling of the title label to 1.2
////        var titleLabelResizeAnimation = new AR.PropertyAnimation(marker.titleLabel, 'scaling', null, 1.0, kMarker_AnimationDuration_Resize, new AR.EasingCurve(AR.CONST.EASING_CURVE_TYPE.EASE_OUT_ELASTIC, {
////            amplitude: 2.0
////        }));
////        // create AR.PropertyAnimation that animates the scaling of the description label to 1.2
////        var descriptionLabelResizeAnimation = new AR.PropertyAnimation(marker.descriptionLabel, 'scaling', null, 1.0, kMarker_AnimationDuration_Resize, new AR.EasingCurve(AR.CONST.EASING_CURVE_TYPE.EASE_OUT_ELASTIC, {
////            amplitude: 2.0
////        }));
//
//        /*
//            There are two types of AR.AnimationGroups. Parallel animations are running at the same time, sequentials are played one after another. This example uses a parallel AR.AnimationGroup.
//        */
//        marker.animationGroup_selected = new AR.AnimationGroup(AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL, [hideIdleDrawableAnimation, showSelectedDrawableAnimation]);
//    }

    // removes function that is set on the onClick trigger of the idle-state marker
    marker.markerDrawable_idle.onClick = null;
    // sets the click trigger function for the selected state marker
    marker.markerDrawable_selected.onClick = Marker.prototype.getOnClickTrigger(marker);

    // enables the direction indicator drawable for the current marker
    marker.directionIndicatorDrawable.enabled = true;

    marker.markerObject.drawables.radar = marker.radardrawablesSelected;
    
    marker.markerDrawable_idle.opacity = 0.0;
    marker.markerDrawable_selected.opacity = 1.0;
    marker.htmlDrawable.opacity = 1.0;
    marker.htmlDrawable.enabled = true;
//    marker.detailImage.opacity = 1.0;
    marker.titleLabel.style.textColor = "#43D8E6";
    marker.descriptionLabel.style.textColor = "#666666";
    
    // starts the selected-state animation
//    marker.animationGroup_selected.start();
};

Marker.prototype.setDeselected = function(marker) {

    marker.isSelected = false;

    marker.markerObject.drawables.radar = marker.radardrawables;

//    if (marker.animationGroup_idle === null) {
//
//        // create AR.PropertyAnimation that animates the opacity to 1.0 in order to show the idle-state-drawable
//        var showIdleDrawableAnimation = new AR.PropertyAnimation(marker.markerDrawable_idle, "opacity", null, 0.6, kMarker_AnimationDuration_ChangeDrawable);
//        // create AR.PropertyAnimation that animates the opacity to 0.0 in order to hide the selected-state-drawable
//        var hideSelectedDrawableAnimation = new AR.PropertyAnimation(marker.markerDrawable_selected, "opacity", null, 0, kMarker_AnimationDuration_ChangeDrawable);
////        // create AR.PropertyAnimation that animates the scaling of the idle-state-drawable to 1.0
////        var idleDrawableResizeAnimation = new AR.PropertyAnimation(marker.markerDrawable_idle, 'scaling', null, 1.0, kMarker_AnimationDuration_Resize, new AR.EasingCurve(AR.CONST.EASING_CURVE_TYPE.EASE_OUT_ELASTIC, {
////            amplitude: 2.0
////        }));
////        // create AR.PropertyAnimation that animates the scaling of the selected-state-drawable to 1.0
////        var selectedDrawableResizeAnimation = new AR.PropertyAnimation(marker.markerDrawable_selected, 'scaling', null, 1.0, kMarker_AnimationDuration_Resize, new AR.EasingCurve(AR.CONST.EASING_CURVE_TYPE.EASE_OUT_ELASTIC, {
////            amplitude: 2.0
////        }));
////        // create AR.PropertyAnimation that animates the scaling of the title label to 1.0
////        var titleLabelResizeAnimation = new AR.PropertyAnimation(marker.titleLabel, 'scaling', null, 1.0, kMarker_AnimationDuration_Resize, new AR.EasingCurve(AR.CONST.EASING_CURVE_TYPE.EASE_OUT_ELASTIC, {
////            amplitude: 2.0
////        }));
////        // create AR.PropertyAnimation that animates the scaling of the description label to 1.0
////        var descriptionLabelResizeAnimation = new AR.PropertyAnimation(marker.descriptionLabel, 'scaling', null, 1.0, kMarker_AnimationDuration_Resize, new AR.EasingCurve(AR.CONST.EASING_CURVE_TYPE.EASE_OUT_ELASTIC, {
////            amplitude: 2.0
////        }));
//
//        /*
//            There are two types of AR.AnimationGroups. Parallel animations are running at the same time, sequentials are played one after another. This example uses a parallel AR.AnimationGroup.
//        */
//        marker.animationGroup_idle = new AR.AnimationGroup(AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL, [showIdleDrawableAnimation, hideSelectedDrawableAnimation]);
//    }

    // sets the click trigger function for the idle state marker
    marker.markerDrawable_idle.onClick = Marker.prototype.getOnClickTrigger(marker);
    // removes function that is set on the onClick trigger of the selected-state marker
    marker.markerDrawable_selected.onClick = null;

    // disables the direction indicator drawable for the current marker
    marker.directionIndicatorDrawable.enabled = false;
    
    marker.markerDrawable_idle.opacity = 0.6;
    marker.markerDrawable_selected.opacity = 0.0;
    marker.htmlDrawable.opacity = 0.0;
    marker.htmlDrawable.enabled = false;
//    marker.detailImage.opacity = 0.0;
    marker.titleLabel.style.textColor = "#ffffff";
    marker.descriptionLabel.style.textColor = "#ffffff";
    
    
    // starts the idle-state animation
//    marker.animationGroup_idle.start();
};

//Marker.prototype.isAnyAnimationRunning = function(marker) {
//
//    if (marker.animationGroup_idle === null || marker.animationGroup_selected === null) {
//        return false;
//    } else {
//        if ((marker.animationGroup_idle.isRunning() === true) || (marker.animationGroup_selected.isRunning() === true)) {
//            return true;
//        } else {
//            return false;
//        }
//    }
//};

// will truncate all strings longer than given max-length "n". e.g. "foobar".trunc(3) -> "foo..."
String.prototype.trunc = function(n) {
    return this.substr(0, n - 1) + (this.length > n ? '...' : '');
};