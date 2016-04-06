# ProgressHUD

## 使用方法
```
将HUD放在所需的视图上 自定义图片
1 、[ProgressHUD showHUDToView:self.view];
[ProgressHUD hiddenHUD:self.view];
```

```
提示文字
2 、[ProgressHUD showTextToView:self.view remindText:@"大龙哥"];
```

```
成功提示
3 、[ProgressHUD showSuccessHUDToView:self.view SuccessText:@"大龙哥"];
```

```
失败提示
4 、[ProgressHUD showFailureHUDToView:self.view failureText:@"大龙哥"];
```

```
加转菊花HUD放在所需视图上
5 、[ProgressHUD showProgressToView:self.view remindText:@"大龙哥"];
```

```
带关闭效果的HUD
6 、[ProgressHUD 带关闭效果的HUD:self.view remindText:@"大龙哥"];
```

```
去除HUD从当前视图
7 、[ProgressHUD hiddenHUD:self.view];
```
