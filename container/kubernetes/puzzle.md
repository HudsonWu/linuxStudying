# 难题

## 会话保持

1. 后端pod启用了自动伸缩，ingress开启了会话保持（根据cookie记住后端pod），后端pod缩容后，cookie指向的pod不存在，临时会出现502错误
