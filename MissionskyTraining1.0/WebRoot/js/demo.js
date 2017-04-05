function() {
  var othis = $(this),
    index = othis.index('.layer-demolist');
  switch (index) {
    case 0:
      //信息框-例1
      layer.alert('见到你真的很高兴', {
        icon: 6
      });
      break;
    case 1:
      //信息框-例2
      layer.msg('你确定你很帅么？', {
        time: 0 //不自动关闭
          ,
        btn: ['必须啊', '丑到爆'],
        yes: function(index) {
          layer.close(index);
          layer.msg('雅蠛蝶 O.o', {
            icon: 6,
            time: 0,
            btn: ['嗷', '嗷', '嗷']
          });
        }
      });
      break;
    case 2:
      //信息框-例3
      layer.msg('这是最常用的吧');
      break;
    case 3:
      //信息框-例4
      layer.msg('不开心。。', {
        icon: 5
      });

      break;
    case 4:
      //信息框-例5
      layer.msg('玩命卖萌中', function() {
        //关闭后的操作
      });
      break;
    case 5:
      //页面层-自定义
      layer.open({
        type: 1,
        title: false,
        closeBtn: 0,
        shadeClose: true,
        skin: 'yourclass',
        content: '自定义HTML内容'
      });
      break;
    case 6:
      //页面层-佟丽娅
      layer.open({
        type: 1,
        title: false,
        closeBtn: 0,
        area: '516px',
        skin: 'layui-layer-nobg', //没有背景色
        shadeClose: true,
        content: $('#tong')
      });
      break;
    case 7:
      //iframe层-父子操作
      layer.open({
        type: 2,
        area: ['700px', '530px'],
        fixed: false, //不固定
        maxmin: true,
        content: 'test/iframe.html'
      });
      break;
    case 8:
      //iframe层-多媒体
      layer.open({
        type: 2,
        title: false,
        area: ['630px', '360px'],
        shade: 0.8,
        closeBtn: 0,
        shadeClose: true,
        content: 'http://player.youku.com/embed/XMjY3MzgzODg0'
      });
      layer.msg('点击任意处关闭');
      break;
    case 9:
      //iframe层-禁滚动条
      layer.open({
        type: 2,
        area: ['360px', '500px'],
        skin: 'layui-layer-rim', //加上边框
        content: ['http://layer.layui.com/mobile', 'no']
      });
      break;
    case 10:
      //加载层-默认风格
      layer.load();
      //此处演示关闭
      setTimeout(function() {
        layer.closeAll('loading');
      }, 2000);
      break;
    case 11:
      //加载层-风格2
      layer.load(1);
      //此处演示关闭
      setTimeout(function() {
        layer.closeAll('loading');
      }, 2000);
      break;
    case 12:
      //加载层-风格3
      layer.load(2);
      //此处演示关闭
      setTimeout(function() {
        layer.closeAll('loading');
      }, 2000);
      break;
    case 13:
      //加载层-风格4
      layer.msg('加载中', {
        icon: 16,
        shade: 0.01
      });
      break;
    case 14:
      //打酱油
      layer.msg('尼玛，打个酱油', {
        icon: 4
      });
      break;
    case 15:
      layer.tips('上', this, {
        tips: [1, '#000']
      });
      break;
    case 16:
      layer.tips('默认就是向右的', this);
      break;
    case 17:
      layer.tips('下', this, {
        tips: 3
      });
      break;
    case 18:
      layer.tips('在很久很久以前，在很久很久以前，在很久很久以前……', this, {
        tips: [4, '#78BA32']
      });
      break;
    case 19:
      layer.tips('不会销毁之前的', this, {
        tipsMore: true
      });
      break;
    case 20:
      //默认prompt
      layer.prompt(function(val, index) {
        layer.msg('得到了' + val);
        layer.close(index);
      });
      break;
    case 21:
      //屏蔽浏览器滚动条
      layer.open({
        content: '浏览器滚动条已锁',
        scrollbar: false
      });
      break;
    case 22:
      //弹出即全屏
      var index = layer.open({
        type: 2,
        content: 'http://layim.layui.com',
        area: ['320px', '195px'],
        maxmin: true
      });
      layer.full(index);
      break;
    case 23:
      //正上方
      layer.msg('灵活运用offset', {
        offset: 't',
        anim: 6
      });
      break;
    default:
      layer.msg('Hi!');
      break;
  }

  //定位到对应的
  var p = gather.demo2.find('p').eq(index);
  var top = p.parent().position().top;
  var ol = gather.demo2.find('.layui-code-ol');

  gather.demo2.find('.layui-code-ol').animate({
    scrollTop: ol.scrollTop() + top
  }, 0);
}