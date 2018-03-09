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
$(//图片渐入渐出效果
     $('.picBrowser').click(e=>{
      $('.picBrowser').fadeOut()
    })
)
$(//视频渐入渐出效果
    $('.show-video').on('click',()=>{
        $('.videoBrowser').fadeIn(()=>{
            $('#videoPlayer')[0].play()
        })
    })
   
)
$(
     $('.videoBrowser').click(e=>{
      $('.videoBrowser').fadeOut()
      $('#videoPlayer')[0].pause    ()
    })
)
