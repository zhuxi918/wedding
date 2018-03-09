
/*
 * 替换视频图片
 * */
function replaceIMGANDVideo(kind){

    if(kind==1){ //图片
        var src= $(".big-list-img .on").find("img").attr("src-data");
        var replace='<img oncontextmenu="return false"  src="'+src+'">';
    }else if(kind==2){ //视频
        var video_url= $(".big-list-img .on").find("img").attr("video_url");
        var video_type=$(".big-list-img .on").find("img").attr("video_type");
        var replace= '<video width="800" height="530" controls="controls"> ' +
            '<source src="'+video_url+'" type="'+video_type+'" /> ' +
            '</video>';
    }
    $(".big-boximg").html(replace);

}

$(function() {
    $(".box3-1f dl").hover(function(){
        $(this).addClass("on").siblings().removeClass("on");
    })
    $(".detail-big-img").click(function(){
        $(".tu-lunbo").show();
        var t = $(".detail-list-img .on").index();
        var List_img = $(".big-list-img i");
        List_img.eq(t).addClass("on").siblings().removeClass("on")
        var kind=List_img.eq(t).attr("kind");
        replaceIMGANDVideo(kind);
    })
    $(".big-box p").click(function(){
        $(".tu-lunbo").hide();//
        $(".big-boximg").html("");
    })
})



$(function(){
    var Big_img = $(".detail-big-img img");
    var List = $(".detail-list-img span");
    var List_img = $(".detail-list-img i");
    var length = List_img.length;
    var List_width = length * 100;
    var w_2 = 0;
    //var min_w = List_width - 469;
    var min_w = Math.max(1, (length - 4)) * 100 + 1;

    List.width(List_width);

    List_img.click(function(){
        $(this).addClass("on").siblings().removeClass("on");
        if($(this).attr("kind") == '2') $(".detail-big-img").find("em").css("display", 'block');
        if($(this).attr("kind") == '1') $(".detail-big-img").find("em").css("display", 'none');
        img();
    })
    function img(){
        var src = $(".detail-list-img .on").find("img").attr("src-data");
        Big_img.attr("src",src);
    }



    $(".detail-prev").click(function(){
        var t = $(".detail-list-img .on").index();
        if(t <= 0 ) return
        t -=1;
        var cur_img =  List_img.eq(t);
        cur_img.addClass("on").siblings().removeClass("on");
        if( cur_img.attr("kind") == '2') $(".detail-big-img").find("em").css("display", 'block');
        if( cur_img.attr("kind") == '1') $(".detail-big-img").find("em").css("display", 'none');
        img();
        if(w_2 <= 0) return;
        w_2 -= 100;
        List.animate({"margin-left":-w_2},500);
        cur_img.addClass("on").siblings().removeClass("on");
    })
    $(".detail-next").click(function(){
        var t = $(".detail-list-img .on").index();
        if(t >= length-1 ) return
        t += 1;
        var cur_img =  List_img.eq(t);
        List_img.eq(t).addClass("on").siblings().removeClass("on");
        if( cur_img.attr("kind") == '2') $(".detail-big-img").find("em").css("display", 'block');
        if( cur_img.attr("kind") == '1') $(".detail-big-img").find("em").css("display", 'none');
        img();
        if(w_2 >= min_w) return;
        w_2 += 100;
        List.animate({"margin-left":-w_2 + 100},500);

    })
})

$(function(){
    var Big_img = $(".big-boximg img");
    var List = $(".big-list-img span");
    var List_img = $(".big-list-img i");
    var length = List_img.length;
    var List_width = length * 95;
    var w_2 = 0;
    var min_w = List_width - 750;

    List.width(List_width);

    /*List_img.click(function(){
        $(this).addClass("on").siblings().removeClass("on")
        img()
    })*/
    function img(){
        //var src = $(".detail-list-img .on").find("img").attr("src");//������ʾ��Сͼ����ȡsrc_data yyy
        var src = $(".big-list-img .on").find("img").attr("src-data");
        Big_img.attr("src",src)
    }

    $(".big-prev").click(function(){
        var t = $(".big-list-img .on").index();
        var kind=List_img.eq(t).attr("kind");
        if(t <= 0 ) return
        t -=1;
        List_img.eq(t).addClass("on").siblings().removeClass("on");
        //获取当前元素信息
        var kind=List_img.eq(t).attr("kind");
        replaceIMGANDVideo(kind);
        img();

        if(w_2 <= 0) return;
        w_2 -= 95;
        List.animate({"margin-left":-w_2},500);
        List_img.eq(t).addClass("on").siblings().removeClass("on");
    })
    $(".big-next").click(function(){
        var t = $(".big-list-img .on").index();

        if(t >= length-1 ) return
        t += 1;
        List_img.eq(t).addClass("on").siblings().removeClass("on");
        //获取当前元素信息
        var kind=List_img.eq(t).attr("kind");
        replaceIMGANDVideo(kind);
        img();

        if(w_2 >= min_w) return;
        w_2 += 95;
        List.animate({"margin-left":-w_2 + 95},500)

    })
})