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

            <div id="map">

            </div>



            <?php echo $content_bottom; ?></div>
        <?php echo $column_right; ?></div>
</div>
<?php
$array=array();
echo "<pre>";
print_r($getAllStoreList);
foreach($getAllStoreList as $getAllStorelis){
$address="Store Name :".$getAllStorelis['name'].'<br>';
$address.="Address :".$getAllStorelis['address'].'<br>';
$address.="Telephone :".$getAllStorelis['telephone'].'<br>';
$address.="Fax :".$getAllStorelis['fax'].'<br>';
$address.="Store Timing :".$getAllStorelis['open'].'<br>';
$address.="Comment :".$getAllStorelis['comment'].'<br>';
$geoCode=explode(',',$getAllStorelis['geocode']);
$storeData=array($address,$geoCode[1],$geoCode[0]);
$array[]=$storeData;
}
echo $out=json_encode(array_values($array));
die;
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
$out=array_values($array);

?>
<script type="text/javascript">

    function initMap() {
        var locations = <?php echo json_encode($out); ?> ;
                var map = new google.maps.Map(document.getElementById('map'), {
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

</script>

<script src="https://maps.googleapis.com/maps/api/js?key=<?php echo $store_locator_google_map_api;?>&callback=initMap"></script>

<style type="text/css">
    #map{
        position: unset !important; 
        height: 100%;

    }
    #map > div{
    top:76px !important;
    height: 86% !important;
    }
</style>
<?php echo $footer; ?>
