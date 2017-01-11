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
            <div style="float: left;margin-top: 30px;width: 36%;">
                <ul class="list-group">
                    <?php
                    $ii=0;
                    foreach($getAllStoreList as $getStoreList){
                    $geoCode=explode(',',$getStoreList['geocode']);
                    ?>
                    <li class="list-group-item" onclick="setClickLocation(<?php echo $geoCode[0]; ?>,<?php echo $geoCode[1]; ?>,<?php echo $ii;?>)">
                        <div>Name</div>
                        <div>Address</div>
                        <div>Phone</div>
                    </li>
                    <?php
                    $ii++;
                    }
                    ?>
                </ul>
            </div>
            <div id="map" class='' style="float:left;width:70%">

            </div>



            <?php echo $content_bottom; ?></div>
        <?php echo $column_right; ?></div>
</div>
<?php
$array=array();

foreach($getAllStoreList as $getAllStorelis){
$address="Store Name :".$getAllStorelis['name'].'<br>';
$address.="Address :".$getAllStorelis['address'].'<br>';
$address.="Telephone :".$getAllStorelis['telephone'].'<br>';
$address.="Fax :".$getAllStorelis['fax'].'<br>';
$address.="Store Timing :".$getAllStorelis['open'].'<br>';
$address.="Comment :".$getAllStorelis['comment'].'<br>';
$geoCode=explode(',',$getAllStorelis['geocode']);
$storeData=array($address,$geoCode[0],$geoCode[1]);
$array[]=$storeData;
}
$out=array_values($array);

?>
<script type="text/javascript">
    var map="";
    var marker, i;
    var locations;
    var infowindow;
    function initMap() {
        locations = <?php echo json_encode($out); ?> ;
        console.log(locations);
                map = new google.maps.Map(document.getElementById('map'), {
                    zoom: 10,
                    center: new google.maps.LatLng(-34.922508, 138.609161),
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                });

        infowindow = new google.maps.InfoWindow({});
        
        for (i = 0; i < locations.length; i++) {
            marker = new google.maps.Marker({
                position: new google.maps.LatLng(locations[i][1], locations[i][2]),
                icon: "https://maps.google.com/mapfiles/kml/shapes/info-i_maps.png",
                map: map
            });
            console.log(marker);
            google.maps.event.addListener(marker, 'click', (function (marker, i) {
                return function () {
                    infowindow.setContent(locations[i][0]);
                    infowindow.open(map, marker);
                }
            })(marker, i));
        }
    }
    function setClickLocation(lat1,lng1,ii){
        map.setCenter(new google.maps.LatLng(lat1,lng1));
               
                    infowindow.setContent(locations[ii][0]);
                    infowindow.open(map, marker);
    }
</script>

<script src="https://maps.googleapis.com/maps/api/js?key=<?php echo $store_locator_google_map_api;?>&callback=initMap"></script>

<style type="text/css">
    #map{
        position: unset !important; 
        height: 100%;

    }
    #map > div{
   height: 100% !important; position: absolute !important; top: 0px !important; background-color: rgb(229, 227, 223); width: 50% !important; left: 50% !important;
    }
</style>
<?php echo $footer; ?>
