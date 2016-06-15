// Empty JS for your own code to be here

$(".menu-icon").click(function(){
    $(".sidebar").toggleClass("show-nav");
	$(".body-wrap").toggleClass("full-width");	
}); 


$(function(){
    $('#scroll').slimScroll({
        height: '380px'
    });
});