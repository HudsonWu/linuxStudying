# Consolas

Consolas是一套等宽的字体, 属无衬线字体

linux下安装
```sh
sudo mkdir -p /usr/share/fonts/consolas
sudo cp YaHei.Consolas.1.12.ttf /usr/share/fonts/consolas/
sudo chmod 644 /usr/share/fonts/consolas/YaHei.Consolas.1.12.ttf
cd /usr/share/fonts/consolas
sudo mkfontscale && sudo mkfontdir && sudo fc-cache -fv
```

other fonts:
+ Monaco：https://github.com/cstrap/monaco-font
+ Source Code Pro：https://github.com/adobe-fonts/source-code-pro
