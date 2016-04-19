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