$(function () {
	function slide (opts) {
		this.imgLength = opts.imageList.length;
		this.currentIndex = 0;
		this.imageList = opts.imageList;
		this.navList = opts.navList; 
		this.nextBtn = opts.nextBtn;
		this.preBtn = opts.preBtn;

		this.intervalFunc;

		this.init();
	}

	var slideProto = slide.prototype;

	slideProto.play = function (index) {
		if (index != this.currentIndex) {
			this.imageList.fadeOut();
			this.imageList.eq(index).fadeIn();
            this.navList.eq(index).siblings().removeClass('on');
            this.navList.eq(index).addClass('on');
			this.currentIndex = index;
		}
	};

	slideProto.init = function () {
		this.initBtn();

		this.initAutoPlay();
	};

	slideProto.initAutoPlay = function () {
		var that = this;

		if (that.intervalFunc) {
			clearInterval(that.intervalFunc);
		}

		that.intervalFunc = setInterval(function () {
			var index = (that.currentIndex + 1) == (that.imgLength) 
				? 0
				: (that.currentIndex + 1); 
			that.play(index);
		}, 5000);
	};

	slideProto.initBtn = function () {
		var that = this;

		if (that.imgLength <= 1) {
			$(that.nextBtn).hide();
			$(that.preBtn).hide();
			$(that.navList).hide();

			return;
		}
		$(that.nextBtn).on('click', function () {
			var index = (that.currentIndex + 1) == (that.imgLength) 
				? (0) 
				: (that.currentIndex + 1);
			that.play(index);
			that.initAutoPlay();
		});

		$(that.preBtn).on('click', function () {
			var index = (that.currentIndex - 1) >= 0
				? (that.currentIndex - 1) 
				: (that.imgLength -1); 
			that.play(index);
			that.initAutoPlay();
		});	

		$(that.navList).on('click', function (ev) {
			var index = $(ev.target).index();
			that.play(index);
			that.initAutoPlay();
		});
	};

	new slide({
		imageList: $('.nav-slide .link'),
		nextBtn: $('.nav-slide .icon-next'),
		preBtn: $('.nav-slide .icon-pre'),
		navList: $('.list-thumb li')
	});

	$('.aside-service .item').on('mouseenter', function (ev) {
		$(this).find('.service').parent().siblings('.service-detail').show();
	});

	$('.aside-service .item').on('mouseleave', function (ev) {
		$(this).find('.service').parent().siblings('.service-detail').hide();
	});	

	$('.back-top').on('click', function (ev) {
		$('html,body').animate({scrollTop: '0px'}, 500);
	});

});