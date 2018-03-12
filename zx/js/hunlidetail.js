// $(
//     $('.smPic li').on('click',(e)=>{
//         $('.mainPic>src')[0].src=e.target.src;
        
//     })
// )
$(
    //console.log($('.smPic li'))
    
    $('.smPic li').click(e=>{
        $('.mainPic>img').attr('src',$(e.target).attr('src'))
        
    })

)
$(
    $(window).scroll((e)=>{
       if ($(e.target).scrollTop()>200) {
           $('.scrollHeader').show()
         
       }else{
        $('.scrollHeader').hide()   
       }    
    })
)

$(
    $(window).scroll(e=>{
        if ($(e.target).scrollTop()>600) {
            $('.tabs').addClass('scollFloat')
        }else{
            $('.tabs').removeClass('scollFloat')
          
        }
    })
)
$(
    $('.tabs a').click(e=>{
        $(e.target).addClass('active').siblings().removeClass('active')
    })
)

$(
    $(".item").click(e=>{
        //window.location.href='hunlidetail.html'
        console.log(e)
    })
)
