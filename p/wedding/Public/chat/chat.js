/*
 * hunliji.com Chat UI Framework
 * Copyright (c) 2015 AUTHORS.hsj
 * Version 1.0
 */
(function ($) {
    $.fn.extend({
        "bindRead": function () {
            $(this).click(function () {
                $('#msg-reply').show();
                if ($(this).hasClass('temprow')) {
                    $('.msg-mod').html('');
                    $('.msg-tit p .msg-name').text($(this).find('span').text());
                    $(this).addClass('hover').siblings().removeClass('hover');
                    now_channel = null;
                    now_id = $(this).data('uid');
                } else {
                    weddingChat.getChannel($(this).attr('id').replace('socketuser', ''));
                }
                return false;
            })
            $(this).find('.close').click(function (e) {
                e.stopPropagation();
                if ($(this).parent().hasClass('temprow')) {
                    $(this).parent().remove();
                    weddingChat.channelInit();
                } else {
                    weddingChat.delChannel($(this).parent().attr('id').replace('socketuser', ''));
                }
            })

        }
    });
})(jQuery);
var user_token, user_id, now_id, now_channel, domain_home, domain_socket, ws, show_dialog = false, is_open = false, is_loading = false, has_new = new Array(), audio;
var t = {
    "\u5927\u7b11": "daxiao",
    "\u4e24\u773c\u653e\u5149": "fangguang",
    "\u62a0\u9f3b": "koubi",
    "\u4e0d\u9ad8\u5174": "bugaoxing",
    "\u5410\u820c": "tushe",
    "\u59d4\u5c48": "weiqu",
    "\u5fae\u7b11": "weixiao",
    "\u5413": "xia",
    "\u9119\u89c6": "bishi",
    "\u4e0d\u9ad8": "bugaoxing",
    "\u5927\u54ed": "daku",
    "\u9f13\u638c": "guzhang",
    "\u6c57": "han",
    "\u9177": "ku",
    "\u4eb2\u4eb2": "qinqin",
    "\u751f\u6c14": "shengqi",
    "\u559c\u6b22": "xihuan",
    "\u6655": "yun",
    "\u6293\u72c2": "zhuakuang",
    "\u6253": "da",
    "\u54c8\u6b20": "haqian",
    "\u54fc": "heng",
    "\u6487\u5634": "piezui",
    "\u7761\u89c9": "shuijiao",
    "\u518d\u89c1": "zaijian",
    "\u574f\u7b11": "huaixiao",
    "\u53ef\u601c": "kelian",
    "\u8d31\u7b11": "jianxiao",
    "\u7591\u95ee": "yiwen",
    "\u65e0\u8bed": "wuyu",
    "\u6012\u9a82": "numa",
    "\u56f0": "kun",
    "\u53e3\u7f69": "kouzhao",
    "\u8d5e": "zan",
    ok: "ok",
    "\u8036": "ye",
    "\u95ed\u5634": "bizui"
};
var url_channel = 'api/v3/channels/';
var url_curl = 'p/wedding/Public/chat/pageinfo.php';
var url_avatar = 'p/wedding/index.php/Web/Login/getUserAvatar';
var hello_text = '现在可以和商家对话了';
var time_write;
var weddingChat = {
    run: function () {
        weddingChat.prepare();
        weddingChat.linkEvent();
        if (!weddingChat.check()) {
            return false;
        }
        weddingChat.socket();
        weddingChat.bindEvent();
        weddingChat.getUsers();
    },
    prepare: function () {
        var chat_html = '<div id="fixed-msg">';
        chat_html += '<p class="msg-con ng-scope" style="display: none">';
        chat_html += '<i class="msg-icon"></i>';
        chat_html += '<em class="tips-a">私信聊天</em>';
        chat_html += '<em class="tips-b">你有新私信</em></p>';

        chat_html += '<p class="non-msg ng-scope">';
        chat_html += '<i class="msg-icon"></i>未登录</p>';
        chat_html += '</div>';

        chat_html += '<div class="xubox_layer" id="xubox_layer" >';
        chat_html += '<div class="xubox_main">';
        chat_html += '<div class="xubox_page">';
        chat_html += '<div id="msg-layer" class="msg-layer" style="display: block;">';
        chat_html += '<h3 class="msg-tit">';
        chat_html += '<p><em class="msg-name ng-binding"></em> 对话中 <em class="msg-write" style="color: #CC5252"></em></p>';
        chat_html += '<em class="close"></em></h3>';
        chat_html += '<dl class="msg-main">';
        chat_html += '<dt class="msg-user nano"></dt>';
        chat_html += '<dd class="msg-content"><dl class="msg-box"><dd class="msg-wrap nano"><ul class="msg-mod content">';
        chat_html += '</ul></dd></dl></dd></dl>';
        chat_html += '<div class="msg-btn">';
        chat_html += '<span class="all-msg"></span>';
        chat_html += '<div class="emoji-box"><ul>';
        var n = 0;
        for (var i in t) {
            if (n % 16 == 0 && n > 0)
                chat_html += '</ul><ul>';
            n++
            chat_html += '<li data-val="' + i + '"><img src="http://www.hunliji.com/assets/backend/emoji/' + t[i] + '@2x.png"/></li>';
        }
        chat_html += '</ul></div>';
        chat_html += '<div class="msg-reply" id="msg-reply">';
        chat_html += '<div class="progress progress-striped"><div class="progress-bar progress-bar-info"><span class="sr-only"></span></div></div>';
        chat_html += '<input class="msg-txt ng-pristine ng-untouched ng-valid" placeholder="输入套餐/案例的网址即可发送作品"/>';
        chat_html += '<span id="pic-btn" class="pic-btn"></span>';
        chat_html += '<span id="emoji-btn" class="emoji-btn"></span>';
        chat_html += '<button type="button" class="btn">发送</button>';
        chat_html += '</div></div>';
        chat_html += '</div></div></div></div>';
        $('body').append(chat_html);
        audio = new Audio("http://www.hunliji.com/p/wedding/Public/chat/msg.ogg");
        var script = document.createElement("script");
        script.src = 'http://test.hunliji.com/p/wedding/Public/chat/voice.js';
        document.head.appendChild(script);

    },
    check: function () {
        if ($('#user_token').length == 0 ||
            $('#user_id').length == 0 ||
            $('#domain_home').length == 0 ||
            $('#domain_socket').length == 0) {
            return false;
        } else {
            user_token = $('#user_token').val();
            user_id = $('#user_id').val();
            domain_home = $('#domain_home').val();
            domain_socket = $('#domain_socket').val();

            if (user_id == '' || user_token == '')
                return false;
            return true;
        }
    },
    socket: function () {
        ws = new WebSocket("ws://" + domain_socket.replace('http://', '').replace('/', '') + "/websocket?os=web");
        ws.onopen = function (event) {
            $('.non-msg').hide().siblings().show();
            is_open = true;
        };
        ws.onclose = function () {
            $('.non-msg').show().siblings().hide();
            show_dialog = false;
            $('#xubox_shade').remove();
            $('#xubox_layer').hide();
            $('.msg-list').remove();
            $('.msg-mod').html('');
            is_open = false;
            weddingChat.run();
        };
        ws.onmessage = function (event) {
            var res = JSON.parse(event.data);
            if (res[0][0] == 'new_message') {
                if (res[0][1].hasOwnProperty('success')) { //回调接口
                    $('.emoji-box').hide();
                    if (res[0][1].hasOwnProperty('id') && res[0][1].success == false) {
                        $(".all-msg").text(res[0][1].data.msg);
                        $('.msg-line' + res[0][1].data.id).append('<i onclick="return weddingChat.reSend(\'' + res[0][1].data.id + '\');" title="发送失败，点击重发" class="error">!</i>');
                    } else {
                        if ($('.wstalkto' + now_id).hasClass('temprow')) {
                            $('.wstalkto' + now_id).attr('id', 'socketuser' + res[0][1].data.channel_id);
                            $('.wstalkto' + now_id).removeClass('temprow');
                        }
                        $(".all-msg").text('发送消息成功！');
                    }
                } else {  //监听接口
                    var obj = res[0][1].data.message;
                    if (obj == hello_text || obj.from == user_id)
                        return false;
                    if (!show_dialog)
                        $('#fixed-msg p').addClass('hover');
                    audio.play();
                    if ($('#socketuser' + obj.channel).length == 0) {
                        var is_temp_remove = false;
                        if($('.wstalkto' + obj.from ).length){
                            $('.wstalkto' + obj.from ).remove();
                            is_temp_remove = true;
                        }
                        var new_user = '';
                        new_user += '<li class="msg-row wstalkto' + obj.from + '" id="socketuser' + obj.channel + '">';
                        new_user += '<img class="logo" src=' + obj.speaker.avatar + '>';
                        new_user += '<span>' + obj.speaker.nick + '</span>';
                        new_user += '<i class="close">×</i>';
                        new_user += '<i class="tips"></i>';
                        new_user += '</li>';
                        $('.msg-user ul').prepend(new_user);
                        $('.msg-user li:first').bindRead();
                        $.ajax({
                            url: domain_home + url_avatar,
                            type: 'POST',
                            data: 'id=' + obj.from,
                            success: function (res) {
                                $('#socketuser' + obj.channel).find('img').attr('src', res.logo);
                                if(is_temp_remove) weddingChat.getChannel(obj.channel);
                            }
                        });
                    } else {
                        if (obj.channel == now_channel) {
                            $('.msg-write').text('');
                            if(time_write)
                                window.clearTimeout(time_write);
                            $('.msg-mod').append(weddingChat.releaseMsg(obj));
                            weddingChat.scrollLast();
                            weddingChat.sendRead(obj.channel);
                        } else {

                            $('#socketuser' + obj.channel).append('<i class="tips"></i>');
                            //if(!show_dialog){
                            var clone = $('#socketuser' + obj.channel).clone();
                            $('#socketuser' + obj.channel).remove();
                            $('.msg-user ul').prepend(clone);
                            $('.msg-user li:first').bindRead();
                            //}
                        }
                    }
                }
            }
            if (res[0][0] == 'websocket_rails.ping') {
                var p = ["websocket_rails.pong"];
                ws.send(JSON.stringify(p));
               // console.log(p)
            }

            if (res[0][0] == 'read_message') {
                /*var read_channel = res[0][1].data.channel_id;
                if(read_channel==now_channel){
                    $('.message_status').text('已读')
                }*/ 
                $('.message_status').text('已读')
            }

           // console.log(res[0][0] );
            if (res[0][0] == 'writing_message') {
                var obj = res[0][1].data;
                if (obj.to_user_id == user_id && obj.from_user_id==now_id)
                {
                    $('.msg-write').text('对方正在输入中...');
                    time_write = window.setTimeout(function(){
                        $('.msg-write').text('');
                    },10000);
                }
            }

        }
    },
    linkEvent: function () {
        $('.wedding-chat').click(function () {
           // console.log($(this).data('gid'))
            if ($(this).data('gid'))
                weddingChat.createChat($(this).data('gid'), false);
            return false;
        });
        $('.wedding-chat-product').click(function () {
            if ($(this).data('gid'))
                weddingChat.createChat($(this).data('gid'), true);
            return false;
        });
    },
    bindEvent: function () {
        $('.msg-reply button').click(function () {
            weddingChat.sendMessage();
        });
        weddingChat.uploadImg('pic-btn', 'msg-reply', '10mb');
        $('#fixed-msg').click(function () {
            if (is_open)
                weddingChat.openChat();
            return false;
        });
        $('.msg-tit .close').click(function () {
            show_dialog = false;
            $('#xubox_shade').remove();
            $('#xubox_layer').hide();
        });
        $('#msg-reply .msg-txt ').keydown(function (e) {
            if (e.keyCode == 13) {
                weddingChat.sendMessage();
            }
            return true;
        });
        $('#msg-reply .msg-txt ').focus(function () {
            weddingChat.sendNotice();
            return true;
        });
        $('#emoji-btn').click(function () {
            $('.emoji-box').toggle();
        });
        $('.emoji-box li').click(function () {
            $('.msg-txt').val($('.msg-txt').val() + '[' + $(this).data('val') + ']');
            $('.emoji-box').hide();
        });
    },
    sendNotice: function () {
        if(user_id&&user_id!=null&&now_id&&now_id!=null){
            var msg = ["writing_message", {"channel": "", "data": {"from_user_id":parseInt(user_id),"to_user_id":parseInt(now_id)}, "id": "", "token": user_token}];
            ws.send(JSON.stringify(msg));
        }
    },
    sendMessage: function () {
        var msg_id = (new Date).getTime();
        var tx = $('.msg-txt').val();
        if (tx == '') {
            return false;
        }
        if (is_product_url(tx)) {
            $('.msg-txt').val('');
            $.ajax({
                url: domain_home + url_curl,
                type: 'POST',
                data: 'url=' + tx,
                dataType: 'JSON',
                success: function (result) {
                    if(now_id&&now_id!=null){
                        var data = weddingChat.buildTextMessage(result, now_id, 'opu');
                        var msg = ["new_message", {"channel": now_channel, "data": data, "id": 2, "token": user_token}];
                        ws.send(JSON.stringify(msg));
                        $('.msg-mod').append(weddingChat.releaseMsg(msg[1].data.message, true));
                        weddingChat.scrollLast();
                        $('.wstalkto' + now_id).find('.tips').remove();
                        $(".all-msg").text('发送消息成功！');
                    }else{
                        console.log('fail')
                    }
                }
            });
        } else {
            if(now_id&&now_id!=null){
                var data = weddingChat.buildTextMessage(tx, now_id, 'text');
                var msg = ["new_message", {"channel": now_channel, "data": data, "id": msg_id, "token": user_token}];
                $('.msg-mod').append(weddingChat.releaseMsg(msg[1].data.message));
                weddingChat.scrollLast();
                ws.send(JSON.stringify(msg));
                $('.msg-mod li:last').data('sm', JSON.stringify(msg))
                $('.wstalkto' + now_id).find('.tips').remove();
                $('.msg-txt').val('');
                $(".all-msg").text('发送消息成功！');
            }else{
                console.log('fail')
            }
        }
    },
    sendRead:function (id) {
        var msg = ["read_message", {"data": {"channel_id":id}}];
        ws.send(JSON.stringify(msg));
    },
    reSend: function (id) {
        var li = $('.msg-line' + id).parent();
        li.find('.error').remove();
        ws.send(li.data('sm'));
    },
    createChat: function (uid, flag) {
        if (!ws) {
            alert('请先登录');
            return false;
        }
        if (is_loading)
            return false;
        if ($('.wstalkto' + uid).length > 0) {
            var clone = $('.wstalkto' + uid).clone();
            $('.wstalkto' + uid).remove();
            $('.msg-user ul').prepend(clone);
            $('.msg-user li:first').bindRead();
            $('.wstalkto' + uid).addClass('hover');
            weddingChat.openChat();
            $('.msg-tit p .msg-name').text($('.wstalkto' + uid).find('span').text());
            now_channel = null;
            now_id = uid;
            if (flag)
                weddingChat.wellcome(uid);
        } else {
            is_loading = true;
            $.ajax({
                url: domain_home + url_avatar,
                type: 'POST',
                data: 'id=' + uid,
                success: function (res) {
                    res = JSON.parse(res);
                    is_loading = false;
                    var new_user = '';
                    new_user += '<li class="msg-row hover temprow wstalkto' + uid + '">';
                    new_user += '<img class="logo" src="' + res.logo + '">';
                    new_user += '<span>' + res.nick + '</span>';
                    new_user += '<i class="close">×</i>';
                    new_user += '</li>';
                    $('.msg-user ul').prepend(new_user);
                    $('.msg-user li:first').bindRead();
                    $('.msg-user li:first').data('uid', uid);
                    $('.wstalkto' + uid).addClass('hover').siblings().removeClass('hover');
                    $('.msg-mod').text('');
                    $('.msg-tit p .msg-name').text(res.nick);
                    now_channel = null;
                    now_id = uid;
                    weddingChat.openChat();
                    if (flag)
                        weddingChat.wellcome(uid);
                }
            });
        }
    },
    wellcome: function (uid) {
        is_loading = true;
        $.ajax({
            url: domain_home + url_curl,
            type: 'POST',
            data: 'url=' + window.location.href,
            dataType: 'JSON',
            success: function (result) {
                var data = weddingChat.buildTextMessage(result, uid, 'opu');
                var msg = ["new_message", {"channel": now_channel, "data": data, "id": 2, "token": null}];
               // console.log(msg[1].data.message);
                is_loading = false;
                ws.send(JSON.stringify(msg));
                $('.msg-mod').append(weddingChat.releaseMsg(msg[1].data.message, true));
                weddingChat.scrollLast();
            }
        });
    },
    openChat: function () {
        $('body').append('<div class="xubox_shade" id="xubox_shade"></div>');
        $('#xubox_layer').show();
        $('#fixed-msg p').removeClass('hover');
        weddingChat.channelInit();
        show_dialog = true;
    },
    getUsers: function () {
        $.ajax({
            headers: {
                "Http-Token": user_token
            },
            url: domain_socket + url_channel,
            type: 'GET',
            success: function (result) {
                var channels = result.channels;
                var str = '<ul class="msg-list content ng-scope">'
                for (var i=0;i<channels.length;i++) {
                    var obj = channels[i];
                    str += '<li class="msg-row wstalkto' + obj.peer.id + '" id="socketuser' + obj.id + '">';
                    if (obj.peer.avatar != undefined)
                        str += '<img class="logo" src="' + obj.peer.avatar + '">';
                    else
                        str += '<img class="logo" src="' + 'http://qnm.hunliji.com/o_1a1j0dkfv1lngmapeue7opgphi.png' + '">';
                    str += '<span>' + obj.peer.nick + '</span>';
                    str += '<i class="close">×</i>';
                    str += '</li>';
                }
                str += '</ul>';
                $('.msg-user').append(str);
                $('.msg-user li').bindRead();
            }
        });
    },
    getChannel: function (id) {
        $.ajaxSetup({
            headers: ''//除去其他js干扰
        });
        $.ajax({
            headers: {
                "Http-Token": user_token
            },
            url: domain_socket + url_channel + id,
            type: 'GET',
            success: function (res) {
                if (res.result) {
                    now_id = res.channel.peer.id;
                    now_channel = res.channel.id;
                    var com = '';
                    $('.msg-name').text(res.channel.peer.nick);
                    $('.msg-write').text('');
                    if(time_write)
                        window.clearTimeout(time_write);
                    var is_last = false;

                    for (var j=0,len=res.channel.messages.length;j<len;j++) {

                        if (j == (res.channel.messages.length - 1))
                            is_last = true;
                        else
                            is_last = false;
                        com += weddingChat.releaseMsg(res.channel.messages[j], is_last);
                    }
                    $('.msg-mod').html(com);
                    weddingChat.scrollLast();
                    $('#socketuser' + id).addClass('hover').siblings().removeClass('hover');
                    $('#socketuser' + id).find('.tips').remove();
                } else {
                    $('.msg-mod').text('');
                }
                $('.emoji-box').hide();
                weddingChat.sendRead(id);
            }
        });
    },
    delChannel: function (id) {
        $.ajax({
            headers: {
                "Http-Token": user_token
            },
            url: domain_socket + url_channel + id,
            type: 'DELETE',
            success: function () {
                $('#socketuser' + id).remove();
                weddingChat.channelInit();
            }
        });
    },
    channelInit: function () {
        if ($('.msg-list li:eq(0)').length > 0) {
            if ($('.msg-list li:eq(0)').hasClass('temprow') == false) {
                var id = $('.msg-list li:eq(0)').attr('id').replace('socketuser', '');
                weddingChat.getChannel(id);
            }
            $('#msg-reply').show();
        } else {
            //$('.msg-mod').html('<li><h3>请在商品页面点击“私信商家”按钮，开启一个对话</h3></li>');
            $('.msg-tit p .msg-name').text('没有人与您');
            $('#msg-reply').hide();
        }
        $(".all-msg").text('');
    },
    releaseMsg: function (item, flag) {
        var com = is_right = '';
        if (item.to && item.to != user_id || item.by_me)
            is_right = 'right';
        var lineclass = item.id ? 'msg-line' + item.id : '';
        com += '<li class="msg-line ng-scope">';
        if (item.content == hello_text) {
            return '';
        } else {
            if (item.kind == 'voice') {
                var vlen = Math.round(item.media_content.voice_duration) * 5;
                if (is_right)
                    com += '<div class="msg-tip" style="padding: 10px 0;float: right;"><span class="msg-tip-voice tip-right" style="min-width:10px;text-align: left;max-width:100px;width: ' + vlen + 'px;cursor: pointer;" data-len="1" onclick="play_phone_voice(' + item.id + ',\'' + item.media_content.path + '\',' + item.media_content.voice_duration + ')">' + Math.round(item.media_content.voice_duration) + '<sup></sup></span>';
                else
                    com += '<div class="msg-tip" style="padding: 10px 10px;"><span class="msg-tip-voice tip-left" data-len="1" style="min-width:10px;max-width:100px;width: ' + vlen + 'px;cursor: pointer;" onclick="play_phone_voice(' + item.id + ',\'' + item.media_content.path + '\',' + item.media_content.voice_duration + ')">' + Math.round(item.media_content.voice_duration) + '<sup></sup></span>';
                com += '<time>' + weddingChat.timeFilter(item.created_at) + '</time></div>';
                com += '</li>';
                voice_init();
                return com;
            }
            com += '<div class="msg-linerow ' + lineclass + ' ' + is_right + '">';

            if(item.kind == 'track'){
                if(item.ext.track.action==5){
                    com += '<a target="_blank" href="' + domain_home + '/hunpin/detail_' + item.ext.track.product.id + '">';
                    com += '<h3 class="ng-binding">' + item.ext.track.product.title + '<br>';
                    if (item.ext.track.product.show_price)
                        com += '<span style="color: #ff3f00;"> ￥' + item.ext.track.product.show_price + '</span><br>';
                    com += '<img class="msgPic" src="' + item.ext.track.product.cover_image.image_path + '"/></h3>';
                }
                if(item.ext.track.action==3){
                    com += '<a target="_blank" href="' + domain_home + '/shop/detail_' + item.ext.track.merchant.id + '">';
                    com += '<h3 class="ng-binding">' + item.ext.track.merchant.name + '<br>';
                    com += '<img class="msgPic" src="' + item.ext.track.merchant.logo_path + '"/></h3>';
                }
                com += '<p class="ng-binding">' + weddingChat.timeFilter(item.created_at) + '</p>';
                com += '</a>';
            }else{
                if (item.kind == 'opu') {
                    var urlkey = item.product_content.actual_price ? 'package' : 'example';
                    com += '<a target="_blank" href="' + domain_home + 'p/wedding/index.php/Web/Detail/detail/type/' + urlkey + '/id/' + item.product_content.id + '">';
                    com += '<h3 class="ng-binding">' + item.product_content.title + '<br>';
                    if (item.product_content.actual_price)
                        com += '<span style="color: #ff3f00;"> ￥' + item.product_content.actual_price + '</span><br>';
                    com += '<img class="msgPic" src="' + (item.product_content.cover_path||'').replace('%7c', '|') + '"/></h3>';
                    com += '</a>';
                } 
                else if (item.kind == 'custom_meal') {
                    com += '<h3 class="ng-binding">' + item.product_content.title + '<br>';
                    if (item.product_content.actual_price)
                        com += '<span style="color: #ff3f00;"> ￥' + item.product_content.actual_price + '</span><br>';
                    com += '<img class="msgPic" src="' + item.product_content.cover_path + '"/></h3>';
                } 
                else if (item.kind == 'product') {
                    com += '<a target="_blank" href="' + domain_home + '/hunpin/detail_' + item.product_content.id + '">';
                    com += '<h3 class="ng-binding">' + item.product_content.title + '<br>';
                    if (item.product_content.actual_price)
                        com += '<span style="color: #ff3f00;"> ￥' + item.product_content.actual_price + '</span><br>';
                    com += '<img class="msgPic" src="' + item.product_content.cover_path + '"/></h3>';
                    com += '</a>';
                } 
                else if (item.kind == 'image') {
                    com += '<h3 class="ng-binding"><a href="#" class="show_img"><img class="msgPic" src="' + item.media_content.path.replace('%7c', '|') + '"></a></h3>';
                    com += '<p class="ng-binding">' + weddingChat.timeFilter(item.created_at) + '</p>';
                } 
                else {
                    com += '<h3 class="ng-binding">' + weddingChat.emojiFilter(item.content) + '</h3>';
                    com += '<p class="ng-binding">' + weddingChat.timeFilter(item.created_at) + '</p>';
                }
            }


            com += '<i class="icon"></i>';
            var is_read_msg = is_right == 'right'&&item.read_time == '0000-00-00 00:00:00'?'未读':'已读';
            var is_read_pos = is_right == 'right'?'left':'right';
            if(is_read_pos=='left'){
                com += '<i class="message_status" style="position: absolute; '+is_read_pos+': -40px; top: 25px;">'+is_read_msg+'</i>';
            }
            com += '</div>';
        }
        com += '</li>';
        return com;
    },
    buildTextMessage: function (e, n, k) {
        var t = {
            user_id: user_id,
            user_avatar: null,
            user_nick: null
        }
        var r = t.user_id + (new Date).getTime() + "";
        if (k == 'text')
            return {
                message: {
                    to: parseInt(n),
                    speaker: {user_id: parseInt(t.user_id), avatar: t.user_avatar, nick: t.user_nick},
                    _id: r,
                    id: r,
                    content: e,
                    kind: k,
                    read_time: '0000-00-00 00:00:00',
                    created_at: (new Date).toISOString().slice(0, 19) + "Z"
                }
            }
        if (k == 'image')

            return {
                message: {
                    to: parseInt(n),
                    speaker: {user_id: parseInt(t.user_id), avatar: t.user_avatar, nick: t.user_nick},
                    _id: r,
                    id: r,
                    media_content: {
                        path: e.path.replace('|', '%7c'),
                        height: e.height,
                        width: e.width
                    },
                    kind: k,
                    read_time: '0000-00-00 00:00:00',
                    created_at: (new Date).toISOString().slice(0, 19) + "Z"
                }
            }
        if (k == 'opu') {
            if (e.actual_price) {
                return {
                    message: {
                        to: parseInt(n),
                        speaker: {user_id: parseInt(t.user_id), avatar: t.user_avatar, nick: t.user_nick},
                        _id: r,
                        id: r,
                        content: e.title,
                        product_content: {
                            actual_price: e.actual_price,
                            id: parseInt(e.id),
                            title: e.title,
                            cover_path: e.path.replace('|', '%7c')
                        },
                        kind: k,
                        read_time: '0000-00-00 00:00:00',
                        created_at: (new Date).toISOString().slice(0, 19) + "Z"
                    }
                }
            } else {
                return {
                    message: {
                        to: parseInt(n),
                        speaker: {user_id: parseInt(t.user_id), avatar: t.user_avatar, nick: t.user_nick},
                        _id: r,
                        id: r,
                        content: e.title,
                        product_content: {
                            id: parseInt(e.id),
                            title: e.title,
                            cover_path: e.path.replace('|', '%7c')
                        },
                        kind: k,
                        read_time: '0000-00-00 00:00:00',
                        created_at: (new Date).toISOString().slice(0, 19) + "Z"
                    }
                }
            }
        }
    },
    emojiFilter: function (str) {
        if (typeof(str) != 'undefined') {
            $.map(t, function (s, f) {
                if (str.indexOf(f)) {
                    str = str.replace(new RegExp('\\[' + f + '\]', "g"), '<img src="http://www.hunliji.com/assets/backend/emoji/' + s + '@2x.png" class="emoji-img">')

                }
            });
            return str;
        }
        return str;
    },
    timeFilter: function (str) {
        if(str){
            str = str.replace('T', ' ').replace('Z', '');
            var curDate = new Date();
            var d = str.split(' ');
            var da = d[0].split('-');
            var db = d[1].split(':');
            curDate.setFullYear(da[0], da[1] - 1, da[2]);
            curDate.setHours(db[0], db[1], db[2]);
            curDate.setHours(curDate.getHours() + 8);
            return getNowFormatDate(curDate);
        }
    },
    scrollLast: function () { 
        $('.msg-mod').scrollTop(99999999999999);
        $('.show_img').click(function (e) {
            e.stopPropagation();
            $('body').append('<div id="img_shade" class="xubox_shade"></div>');
            $('body').append('<div id="img_layer" class="xubox_layer"><img src="' + $(this).find('img').attr('src') + '"/></div>');
            $('#img_shade').click(function () {
                $('#img_layer').remove();
                $('#img_shade').remove();
            })
        })
    },
    uploadImg: function (_pickBtn, _pickBox, max) {
        var progressbar = $(".progress"),
            progressLabel = $(".all-msg");
        Qiniu.uploader({
            runtimes: 'html5,flash,html4',
            browse_button: _pickBtn,
            container: _pickBox,
            drop_element: 'container',
            max_file_size: max,
            flash_swf_url: 'Moxie.swf',
            dragdrop: true,
            unique_names: true,
            multi_selection: false,
            filters: {
                mime_types: [
                    {title: "Image files", extensions: "jpg,gif,png,jpeg,bmp"}
                ]
            },
            chunk_size: '4mb',
            uptoken_url: '/p/wedding/home/APIUtils/image_upload_token',
            domain: 'http://qnm.hunliji.com/',
            auto_start: true,
            init: {
                'FilesAdded': function (up, files) {

                },
                'BeforeUpload': function (up, file) {
                    progressLabel.text('正在上传图片');
                    progressbar.show();
                    progressbar.find('.progress-bar').css('width', 0);
                },
                'UploadProgress': function (up, file) {
                    progressbar.find('.progress-bar').css('width', file.percent + '%');
                },
                'UploadComplete': function () {
                    progressLabel.text('发送图片成功！');
                },
                'FileUploaded': function (up, file, info) {
                    progressbar.hide();
                    var domain = up.getOption('domain');
                    var res = jQuery.parseJSON(info);
                    var img = new Object();
                    img.path = domain + res.image_path;
                    img.width = res.width;
                    img.height = res.height;
                    var data = weddingChat.buildTextMessage(img, now_id, 'image');
                    var msg_id = (new Date).getTime();
                    var msg = ["new_message", {
                        "channel": now_channel,
                        "data": data,
                        "id": msg_id,
                        "token": user_token
                    }];
                    $('.msg-mod').append(weddingChat.releaseMsg(msg[1].data.message));
                    weddingChat.scrollLast();
                    $('.msg-mod li:last').data('sm', JSON.stringify(msg));
                    ws.send(JSON.stringify(msg));
                },
                'Error': function (up, err, errTip) {

                }
            }
        });
    }
};
$(function () {
    var merchantInfo = sessionStorage.getItem('merchant_info');
    var showChat = merchantInfo
        ? JSON.parse(merchantInfo).shop_type != '3'
        : true;
    if (showChat){
        weddingChat.run();
    }
    if (window.location.hash != '#system' && window.location.hash != '#user' && location.href.indexOf('p/wedding/Public/admin/') > 0)
        unreadListener();
});
function getNowFormatDate(date) {
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    var h = date.getHours();
    var m = date.getMinutes();
    var s = date.getSeconds();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    if (h < 10) h = "0" + h;
    if (m < 10) m = "0" + m;
    if (s < 10) s = "0" + s;
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
        + " " + h + seperator2 + m + seperator2
        + s;
    return currentdate;
}
function is_product_url(url) {
    var cash = url.split('/');
    if (cash.length > 2 && cash[2].indexOf('hunliji.com') > -1) {
        if (url.indexOf('/detail/type/') > 0 || url.indexOf('package/detail_') > 0 || url.indexOf('example/detail_') > 0)
            return true;
    }
    return false;
}
var voice_is_init = false, voice_id, voice_flag, voice_source;
function voice_init() {
    if (!voice_is_init)
        RongIMLib.RongIMVoice.init();
    voice_is_init = true;
}
function play_phone_voice(id, url, t) {
    if (voice_id == id) {
        if (voice_flag == 'play') {
            voice_flag = '';
            RongIMLib.RongIMVoice.stop();
        } else {
            voice_flag = 'play';
            RongIMLib.RongIMVoice.stop();
            RongIMLib.RongIMVoice.play(voice_source, t, function () {
                voice_flag = '';
            });
        }
    } else {
        $.ajax({
            url: domain_home + 'p/wedding/Public/chat/encode.php',
            type: 'POST',
            data: 'url=' + url,
            success: function (res) {
                voice_id = id;
                voice_flag = 'play';
                voice_source = res;
                RongIMLib.RongIMVoice.stop();
                RongIMLib.RongIMVoice.play(res, t, function () {
                    voice_flag = '';
                });
            }
        });
    }
}
