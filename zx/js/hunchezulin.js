$(
    $('.tab-option').on('click',e=>{
        e.preventDefault();
        $(e.target.hash).siblings().fadeOut(()=>{
            $(e.target.hash).fadeIn()
        })
    }
    )
)
$(
    $('.show-pic').on('click',()=>{
        $('.picBrowser').fadeIn()
    })
   
)
$(//图片渐入渐出效果 点击传入图片信息
     $('.picBrowser').click(e=>{
      $('.picBrowser').fadeOut()
    })
)
$(//视频渐入渐出效果 点击传入视频信息
    $('.show-video').on('click',()=>{
        $('.videoBrowser').fadeIn(()=>{
            $('#videoPlayer')[0].play()
        })
    })
   
)
$(
     $('.videoBrowser').click(e=>{
      $('.videoBrowser').fadeOut()
      $('#videoPlayer')[0].pause()
    })
)
$(
    $('.car-sPic img').on('click',e=>{
       $('.car-mPic img').attr('src',$(e.target).attr('src'))
    })
)
$(
    $('.show-details span').click(e=>{
        $('.carDetails-container').fadeIn()
    })
)
$(
    $('.showDetails .close').click(e=>{
        $('.carDetails-container').fadeOut()
    })
)
