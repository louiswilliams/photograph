// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var results_list = [];
var share_list= [];
var preview_active = 0;
var $share_add;
var $share_add_preview;
var $share_add_list;
var $share_list_item;
var $share_item_remove;
var $preview_list_item;

$(document).ready(function(){
    $share_add = $("#share_add");
    $share_add_preview = $("#share_list_preview");
    $share_add_list = $("#share_list");
    $share_list_item = $(".share_list_item");
    $share_item_remove = $(".share_item_remove");
    $preview_list_item = $(".preview_list_item");

    $share_add.keyup(function(event){
        query = $share_add.val();
        if(event.which == 38) {
            event.preventDefault();
            if (preview_active > 0) {
                --preview_active;
                render_preview();
            }
        }
        else if (event.which == 40){
            event.preventDefault();
            if (preview_active < results_list.length -1) {
                ++preview_active;
                render_preview();
            }
        }
        else {
            preview_active = 0;
            results_list = [];
            if (query != "") {
                uri = "/search/user/" + query
                $.getJSON(uri, function(data) {
                    results_list = data;
                    render_preview();
                });

            }
            else{
                render_preview();
            }
        }

    }).keypress(function(event){
        if (event.which == 13) {
            event.preventDefault();
            if (results_list.length > 0) {
                share_list[share_list.length] = results_list[preview_active];
                $share_add.val("");
                results_list = [];
                render_preview();
                render_share_list();
                preview_active = 0;
            }
        }
    });

    // $share_list_item.click(function(event) {
    //     event.preventDefault();
    //     alert();
    // });
});

function preview_list_fmt(name, id, active, index) {    
    active_txt = (active) ? "active" : "";
    form  = "<li class='" + active_txt + " preview_list_item list-group-item'>"
    form += "<a href='#'>" + name + "</a>";
    form += "<input type='hidden' name='share_preview[" + index + "]' ";
    form += "value='" + id + "'></li>";
    return form;  
}

function share_list_fmt(name, id, i) {    
    form  = "<li class='share_list_item list-group-item'>" + name;
    form += "<input type='hidden' name='post[shares[" + i + "]]' value='" + id + "'>";
    form += "<a href='#' class='share_item_remove'><span class='glyphicon glyphicon-remove pull-right'></span></a>";
    form += "</li>";
    return form;  
}
function render_preview() {
    $share_add_preview.html("");

    $.each(results_list, function(index, valArr) {
        valArr["active"] = (index==preview_active);
        $share_add_preview.append(preview_list_fmt(valArr["name"],
            valArr["id"],valArr["active"]),index);
    });

    $(".preview_list_item").click(function(event) {
        event.preventDefault();
        alert();
    });
}

function render_share_list(){
    $share_add_list.html("");

    $.each(share_list,function(index,valArr) {
        $share_add_list.append(share_list_fmt(valArr["name"],valArr["active"]),index);    
    });

    $(".share_item_remove").click(function(event) {
        event.preventDefault();
        alert();
    });
} 
