<?php echo $header; ?>
<div class="container">
    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
    </ul>
    <div class="row"><?php echo $column_left; ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-12'; ?>
        <?php } ?>
        <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
            <h1><?php echo $heading_title; ?></h1>
            <div id="map"></div>



            <?php echo $content_bottom; ?></div>
        <?php echo $column_right; ?></div>
</div>
<?php

$array = array(
    array(
       '<strong>Chipotle on Broadway</strong><br>\
                                        5224 N Broadway St<br> Chicago, IL 60640<br>\
                                        <a href="https://goo.gl/maps/jKNEDz4SyyH2">Get Directions</a>',
         41.976816,
         -87.659916
    ),
    array(
         '<strong>Chipotle on Belmont</strong><br>\
                                        1025 W Belmont Ave<br> Chicago, IL 60657<br>\
                                        <a href="https://goo.gl/maps/PHfsWTvgKa92">Get Directions</a>',
        41.939670,
        -87.655167
    ),
);
//echo "<pre>";
//print_r($array);
//echo json_encode($array);
$out=array_values($array);
//echo json_encode($out);
//die;
?>
<script>
    // This example defines an image map type using the Gall-Peters
    // projection.
    // https://en.wikipedia.org/wiki/Gall%E2%80%93Peters_projection

    function initMap() {

        var broadway = {
            info: '<strong>Chipotle on Broadway</strong><br>\
                                        5224 N Broadway St<br> Chicago, IL 60640<br>\
                                        <a href="https://goo.gl/maps/jKNEDz4SyyH2">Get Directions</a>',
            lat: 41.976816,
            long: -87.659916
        };

        var belmont = {
            info: '<strong>Chipotle on Belmont</strong><br>\
                                        1025 W Belmont Ave<br> Chicago, IL 60657<br>\
                                        <a href="https://goo.gl/maps/PHfsWTvgKa92">Get Directions</a>',
            lat: 41.939670,
            long: -87.655167
        };

        var sheridan = {
            info: '<strong>Chipotle on Sheridan</strong><br>\r\
                                        6600 N Sheridan Rd<br> Chicago, IL 60626<br>\
                                        <a href="https://goo.gl/maps/QGUrqZPsYp92">Get Directions</a>',
            lat: 42.002707,
            long: -87.661236
        };

        var locations =<?php echo json_encode($out);?>;
         /*var locations1 = [
            [broadway.info, broadway.lat, broadway.long, 0],
            [belmont.info, belmont.lat, belmont.long, 1],
            [sheridan.info, sheridan.lat, sheridan.long, 2],
        ];*/
        console.log(locations);
        /*console.log(locations1);*/
        var map = new google.maps.Map(document.getElementById('content'), {
            zoom: 13,
            center: new google.maps.LatLng(41.976816, -87.659916),
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });

        var infowindow = new google.maps.InfoWindow({});
        var marker, i;
        for (i = 0; i < locations.length; i++) {
            marker = new google.maps.Marker({
                position: new google.maps.LatLng(locations[i][1], locations[i][2]),
                icon: "https://maps.google.com/mapfiles/kml/shapes/info-i_maps.png",
                map: map
            });

            google.maps.event.addListener(marker, 'click', (function (marker, i) {
                return function () {
                    infowindow.setContent(locations[i][0]);
                    infowindow.open(map, marker);
                }
            })(marker, i));
        }
    }


    //console.log(cities);
</script>

<script src="https://maps.googleapis.com/maps/api/js?key=<?php echo $store_locator_google_map_api;?>&callback=initMap" async defer></script>
<?php echo $footer; ?>
