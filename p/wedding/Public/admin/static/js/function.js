/**
 * js功能函数
 * @author hsj
 * @2015.9.4
 */
$.ajaxSetup({
    headers:''//除去其他js干扰
});
function GetDateStr(AddDayCount) {
    var dd = new Date();
    dd.setDate(dd.getDate()+AddDayCount);
    var y = dd.getFullYear();
    var m = dd.getMonth()+1;
    var d = dd.getDate();
    m = m<10?'0'+m:m;
    d = d<10?'0'+d:d;
    return y+"-"+m+"-"+d;
}
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return r[2]; return null;
}
function cklogin(){
    var _merId = sessionStorage.getItem("merId"),
        _merId_name = sessionStorage.getItem("merId_name"),
        _merId_logo = sessionStorage.getItem("merId_logo");
    if(_merId==null){location.href="/p/wedding/Public/admin/regPath/loginPath.html"}
    $('.logoImg').attr('src',_merId_logo);
    $('.nameTxt').text(_merId_name);
    $('.yonghu').css('opacity',1);
    console.log(_merId,_merId_name,_merId_logo);
    $('.logout').on('click',function(){
        $.ajax({
            url:_config.api['商家退出'],
            type:'get',
            success:function(result){
                if(result.status.RetCode==0){
                    sessionStorage.removeItem("merId"),
                        sessionStorage.removeItem("merId_name"),
                        sessionStorage.removeItem("merId_logo");
                    location.reload()
                }
            }
        })
    });
}
function getCookie(name) {
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
    if(arr=document.cookie.match(reg))
        return unescape(arr[2]);
    else
        return '';
}
function chatCompiler() {
    var str = '';
    var ck = getCookie('HLJ_CHAT').split(',');
    str += '<input type="hidden" id="user_token" value="'+ck[0]+'"/>';
    str += '<input type="hidden" id="user_id" value="'+ck[1]+'"/>';
    str += '<input type="hidden" id="domain_home" value="'+ck[2]+'"/>';
    str += '<input type="hidden" id="domain_socket" value="'+ck[3]+'"/>';
    $('body').append(str);
}
function tableClear(){
    $('.numpage').remove();
    $('.all-box3').remove();
    $('.noorder').remove();
    $('#listbox').html('');
}


function getData(urlext, postdata) {
    tableClear();
    $('#listbox').append(ajaxLoad());
    var ajaxdata = postdata+'&page='+page_now+'&per_page='+per_page;
    $.ajax({
        url: _config.url + urlext,
        type: 'get',
        data:ajaxdata,
        success:function(result){
            tableClear();
            if(result.status.RetCode==0){
                page_max = result.data.page_count;
                page_pre = page_now>1?(page_now-1):1;
                page_next = page_now<page_max?(page_now+1):page_max;
                var str='';

                str += releaseList(result.data.list);
                if(result.data.list.length==0){
                    str += '<div class="noorder"><img src="http://marry.qiniudn.com/o_19ssn0sf619ri14rui521s4t1auum.png"><br>没有相关数据</div>';

                }
                if(window.location.hash=='#income' && result.data.list.length){
                    str += '<div status="5" class="numpage" style="padding: 10px 0;clear: both;text-align: right;">';
                    str += '<a href="#trade" onclick="lookall()" style="color:#f16100;">查看所有交易记录</a>';
                    str += '</div>';
                }else{
                    if(result.data.page_count>0){
                        var pagestr = '<div status="5" class="numpage" style="padding: 10px 0;clear: both;"><ul>';
                        pagestr += '<li class="firstMer" onclick="return gopage(\''+urlext+'\',\''+postdata+'\',  1);">首页</li>';
                        pagestr += '<li class="prevMer" onclick="return gopage(\''+urlext+'\', \''+postdata+'\', '+page_pre+');">上一页</li>';
                        var t =0;
                        for(t;t<result.data.page_count;t++){
                            var p = t+1;
                            if(p<(page_now-2)||p>(page_now+2))
                                continue;
                            pagestr += '<li onclick="return gopage(\''+urlext+'\', \''+postdata+'\', '+p+');">';
                            if(page_now==p)
                                pagestr += '<i class="on">'+p+'</i>';
                            else
                                pagestr += '<i>'+p+'</i>';
                            pagestr += '</li>';
                        }
                        pagestr += '<li class="nextMer" onclick="return gopage(\''+urlext+'\', \''+postdata+'\', '+page_next+');">下一页</li>';
                        pagestr += '<li class="lastMer" onclick="return gopage(\''+urlext+'\', \''+postdata+'\', '+page_max+');">最后一页</li>';
                        pagestr += '</ul>';
                        pagestr += '</div>';
                        $('.rightbox').append(pagestr);
                    }
                }
                $('#listbox').append(str);
                if(typeof extInit=='function')
                    extInit();
            }else if(result.status.RetCode==404){
                $('#listbox').append('<div class="noorder"><img src="http://marry.qiniudn.com/o_19ssn0sf619ri14rui521s4t1auum.png"><br>没有相关数据</div>');
            }else{
                plugAdd.tipMsg('登录超时','350px')
            }
        }
    })
}
function gopage(urlext, postdata, num){
    if(num==page_now)
        return false;
    page_now = num;
    getData(urlext,postdata)
}
function ajaxLoad(){
    return '<div class="noorder">加载中...</div>';
}

function play_sound(t,b,o){
    var audio_tips=new Audio($('#domain_home').val()+"/p/wedding/Public/chat/tips.ogg");
    var audio_book=new Audio($('#domain_home').val()+"/p/wedding/Public/chat/book.ogg");
    var audio_order=new Audio($('#domain_home').val()+"/p/wedding/Public/chat/order.ogg");
    if(t){
        audio_tips.play();
        t=0; console.log("t");
        setTimeout(function(){play_sound(t,b,o)}, 2000);
        return;
    }
    if(b){
        audio_book.play();
        b=0;console.log("b");
        setTimeout(function(){play_sound(t,b,o)}, 5000);
        return;
    }
    if(o){
        audio_order.play();
        o=0;console.log("o");
        setTimeout(function(){play_sound(t,b,o)}, 5000);
        return;
    }
}
function unreadListener(){
    var name=window.location.host,_url=''
    if(name=='admintest.hunliji.com'||name=='test.hunliji.com'){
        _url='http://test.hunliji.com:8083'
    }

    if(name=='www.hunliji.com'||name=='www7.hunliji.com'){
        _url='http://message.hunliji.com'
    }

    $.ajax({
        xhrFields: {
            withCredentials: true
        },
        url: _url+'/api/v1/channels/unread_num',
        type: 'GET',
        success: function (res_ws) {
            if(res_ws.num)
                $('.tabtn-b:eq(0) .message-hint').text(res_ws.num).show();
            else
                $('.tabtn-b:eq(0) .message-hint').hide();
                if($('#user_token').val()){
                    $.ajax({
                headers: {
                    "token": $('#user_token').val()
                },

                url:  '/p/wedding/index.php/home/APINotification/unread_count',
                type: 'GET',
                success: function (res_notice){console.log(res_notice)
                    var role = location.href.split('/');
                    var unall = res_notice.data.unread+res_ws.num;
                    sessionStorage.msgMer = unall;
                    if(res_ws.num==undefined){
                        sessionStorage.msgMer=res_notice.data.unread
                    }
                    if(unall>0){
                        if(unall>99)
                            unall = '99+';
                        role[7]=='shop'?$('.xiaoxi').find('b').text(unall).show():$('.mas-niuniu').find('em').text(unall).show();
                        if(role[7]=='shop'){
                            $('.leftnav').find('b').text(unall).show();
                        }else{
                            $("#menu .i_message b").text(unall).show();
                        /* if($.trim($('#menu :nth-child(5)').text())=='消息'||$.trim($('#menu :nth-child(5)').text())=='消息中心')
                             $('#menu :nth-child(5) b').text(unall).show();
                         else
                             $('#menu :nth-child(6) b').text(unall).show();*/
                        }
                    }else{
                        if(unall>99)
                            unall = '99+';
                        role[7]=='shop'?$('.xiaoxi').find('b').hide():$('.mas-niuniu').find('em').hide();
                        if(role[7]=='shop'){
                            $('.leftnav').find('b').hide();
                        }else{
                            if($.trim($('.leftnav :nth-child(5)').text())=='消息'||$.trim($('.leftnav :nth-child(5)').text())=='消息中心')
                                $('.leftnav :nth-child(5) b').hide();
                            else
                                $('.leftnav :nth-child(6) b').hide();
                        }
                    }
                    if(role[7]=='shop'){
                        $('dl.li2').find('b:eq(0)').text(res_ws.num);
                        $('dl.li2').find('b:eq(1)').text(res_notice.data.unread);
                        $('.xiaoxi').unbind('click').click(function(){
                            $('dl.li2').toggle();
                        });
                    }else{
                        $('.num-niuniu').eq(1).text(res_ws.num);
                        $('.num-niuniu').eq(2).text(res_notice.data.unread);
                        $('.mas-niuniu').unbind('click').click(function(){
                            $('.notice-board').toggle();
                        });
                    }
                    if(res_notice.data.unread)
                        $('.tabtn-b:eq(1) .message-hint').text(res_notice.data.unread).show();
                    else
                        $('.tabtn-b:eq(1) .message-hint').hide();
                    setTimeout(function(){
                        play_sound(res_notice.data.notice_others,res_notice.data.notice_appoints,res_notice.data.notice_orders);
                    }, 5000);

                    $(document).on('click','.merchant-chat',function(){
                        if($(this).data('gid'))
                            weddingChat.createChat($(this).data('gid'), false);
                        return false;
                    });
                    //merchant home guest inform
                    if(res_notice.data.adv_unread){
                        res_notice.data.adv_unread.forEach(function (ele, index, arr) {
                            ele.current_time = res_notice.current_time;
                        });
                    }
                    window.merchantHomeOuter && window.merchantHomeOuter.trigger('load:guest_info', res_notice.data.adv_unread);
                }
            });
                }
        }
    });
}
/**
 * jquery 插件
 * @author hsj
 * @2015.9.4
 */
var page_now = 1;
var page_pre = 1;
var page_next = 1;
var page_max = 1;
var per_page = 10;
(function ($) {
    $.fn.extend({
        "menuRun":function () {
            $(this).click(function(){
                window.location.href = $(this).data('href');
            });
        },
        "tabRun":function () {
            $(this).click(function(){
                window.location.hash = $(this).data('hash');

                if(typeof tabInit=='function')
                    tabInit();
            });
        },
        "changeClickable": function (source, flag) {
            $(this).click(function(){
                var index = $(this).parent().parent().parent().parent().parent().index();
                if(flag===1)
                    var rowdata = source[index];
                else
                    var rowdata = source;
                var rowstr = '';
                var original_money = 0;
                for(var s=0; s<rowdata.ordersubs.length; s++){
                    var rowsub = rowdata.ordersubs[s];
                    rowstr += '<tr>';
                    rowstr += '<td width="200" style="border-right:none;"><span>'+rowsub.product.title+'</span> <i class="color999">规格：'+rowsub.sku.name+'</i></td>';
                    rowstr += '<td width="100">￥'+rowsub.original_money/rowsub.quantity+'<br /> x'+rowsub.quantity+'</td>';
                    rowstr += '<td width="100">￥'+rowsub.original_money+'</td>';
                    rowstr += '<td width="120" class="change_input"><input type="hidden" value="'+rowsub.id+'"><input type="text" value="'+rowsub.actual_money+'"></td>';
                    rowstr += '</tr>';
                    original_money += parseFloat(rowsub.original_money);
                }
                $('.open-box').find('h3 span').text('￥'+original_money);
                $('input[name="shipping_fee"]').val(rowdata.shipping_fee);
                $('.openbox-rmb2').html(rowstr);
                $('.open-box').show();
                $('#change_submit').unbind('click').click(function(){
                    var _datasend = '{"parent_id":"'+rowdata.id+'",';
                    if($('input[name="shipping_fee"]').val()=='' || $('input[name="shipping_fee"]').val()==null){
                        $('input[name="shipping_fee"]').val('0');
                    }
                    _datasend += '"shipping_fee":"'+$('input[name="shipping_fee"]').val()+'",';
                    _datasend += '"data":[';
                    var is_verfy = false;
                    $('.change_input').each(function(fn) {
                        var suborder = rowdata.ordersubs[fn];
                        if (parseFloat($(this).find('input:eq(1)').val()) > parseFloat(suborder.original_money)||parseFloat($(this).find('input:eq(1)').val())<0){
                            is_verfy = true;
                        }
                        if(fn)
                            _datasend += ',';
                        _datasend += '{"actual_money":"'+$(this).find('input:eq(1)').val()+'","order_sub_id":"'+$(this).find('input:eq(0)').val()+'"}';
                    });
                    // if(is_verfy){
                    //     $('.open-box').hide();
                    //     alert('修改后的价格不能超过原价');
                    //     return false;
                    // }
                    _datasend += ']}';
                    changePrice(_datasend, index, flag);
                    $('.open-box').hide();
                    return false;
                });
                $('#change_cancel').click(function(){
                    $('.open-box').hide();
                    return false;
                });
                return false;
            })
        },
        "sendClickable": function (source, flag, container) {
            
            $(this).click(function() {
                if($(this).data('status')!='1'){
                    var is_express = false;
                    var un_changed = false;
                    var pop = $('.open-box1');
                    var index = $(this).parent().parent().parent().parent().parent().index();

                    if(flag===1)
                        var rowdata = source[index];
                    else
                        var rowdata = source;
                    pop.find('.namedress em:eq(0)').text(rowdata.address.buyer_name);
                    pop.find('.namedress em:eq(1)').text(rowdata.address.province+rowdata.address.city);
                    pop.find('.namedress em:eq(2)').text(rowdata.address.mobile);
                    $('.choose em').click(function() {
                        expressSwitch($(this).index());
                    });
                    pop.find('select').val('');
                    pop.find('input').val('');
                    if(rowdata.status==order.status['sent']){
                        if(rowdata.express){
                            pop.find('select').val(rowdata.express.type_code);
                            pop.find('input').val(rowdata.express.tracking_no);
                            expressSwitch(0);
                        }else{
                            expressSwitch(1);
                        }
                    }else{
                        expressSwitch(0);
                    }

                    $('.open-box1').show();
                    $('.open-box1 button:eq(1)').click(function(){
                        $('.open-box1').hide();
                        return false;
                    });
                    $('.open-box1').data('flag', false);
                    $('.open-box1 button:eq(0)').unbind('click').click(function(){

                        var sendata = '{"order_id":"'+rowdata.id+'"';
                        if($('.choose em').eq(0).find('i').hasClass('on')){
                            is_express = true;
                            if($('.open-box1 select').val()==''||$('.open-box1 input').val()=='')
                                return false;
                            sendata += ',"tag_id":"1"';
                            sendata += ',"type_code":"'+$('.open-box1 select').val()+'"';
                            sendata += ',"tracking_no":"'+$('.open-box1 input').val()+'"';
                        }else{
                            sendata += ',"tag_id":"0"';
                        }
                        sendata += '}';
                        if(rowdata.express){
                            if(is_express&&rowdata.express.type_code==$('.open-box1 select').val()&&rowdata.express.tracking_no==$('.open-box1 input').val()){
                                un_changed = true;
                            }
                        }
                        if(un_changed){
                            $('.open-box1').hide();
                            return false;
                        }

                        $.ajax({
                            url: _config.url + _config.api['确认发货'],
                            contentType: "application/json; charset=utf-8",
                            type: 'post',
                            data: sendata,
                            success: function (result) {
                                if (result.status.RetCode == 0) {
                                    rowdata.status = order.status['sent'];
                                    if($('.choose em').eq(0).find('i').hasClass('on')){

                                        if(!rowdata.express)
                                            rowdata.express = new Object();
                                        rowdata.express.type_code = $('.open-box1 select').val();
                                        rowdata.express.tracking_no  = $('.open-box1 input').val();
                                        $('.name-ex').find('li:eq(1)').html('<span>物流公司：</span>'+$('.open-box1 select option:selected').text());
                                        $('.name-ex').find('li:eq(2)').html('<span>物流单号：</span>'+rowdata.express.tracking_no);
                                        $('.name-ex').find('li:eq(3)').html('<span>物流详情：</span>尚无物流信息');
                                        $('.name-ex').parent().addClass('kuai');
                                        $('.name-ex').show();
                                    }else{
                                        rowdata.express = null;
                                        $('.name-ex').parent().removeClass('kuai');
                                        $('.name-ex').hide();
                                    }
                                    if(container=='list'){
                                        $('.all-box3').eq(index).replaceWith(releaseRow(rowdata));
                                        $('.all-box3').eq(index).find('.send_delivery').sendClickable(rowdata, 2, container);
                                    }else{
                                        $('.orders-xq1').find('li:eq(2) em').text(order.status_label[result.data.status]);
                                        $('.orders-xq1').find('li:eq(3)').html('<button id="send_delivery">修改物流</button>');
                                        $('#send_delivery').sendClickable(rowdata, 2, container);
                                    }
                                }else{
                                    plugAdd.tipMsg('登录超时','350px')
                                }
                            }
                        });

                        $('.open-box1').hide();
                        return false;
                    });
                    return false;
                    }else{
                    $('body').append('<div class="mask"><div><p>这笔订单还有退款未处理</p><button class="mask-sure">确定</button></div></div>')
                    $('body').on('click','.mask-sure',function(){
                        $('.mask').remove();
                    })
                }
            })                     
        }
    });
})(jQuery);