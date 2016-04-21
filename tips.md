# tips
* 某个View autoLayout动画不执行,使用它的superView执行(修改约束)
* 某个View 在它的SuperView的范围之外时不会响应触摸事件,若要响应,可以重写hitTest方法

        -(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
            UIView *view = [super hitTest:point withEvent:event];
            if (view == nil) {
        
               CGPoint tempoint = [self.calloutView.button convertPoint:point fromView:self];
               if (CGRectContainsPoint(self.calloutView.button.bounds, tempoint)){
            
               view = self.calloutView.button;
               }
            }
            return view;
          }  
 * 如果一个app在删除之前applicationIconBadgeNumber 没有清零,那重新安装之后applicationIconBadgeNumber系统不会自动清零,解决办法是代码里面app启动的时候清零一下
 
 * imageView 默认不会把=超出边界的图片部分减掉
 
       iconView.layer.masksToBounds = YES;
       
 * block 内部只需要关心传入什么值,返回什么值,调用block的地方只需要关心什么时候调用block,以及传入什么值,回收什么值
 