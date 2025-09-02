# Z.ai2api
将 Z.ai 代理为 OpenAI Compatible 格式，支持免 Cookie、智能处理思考链等功能  
基于 https://github.com/kbykb/OpenAI-Compatible-API-Proxy-for-Z 使用 AI 辅助重构。

## 限制
Python 3.12+

## 功能
- 支持根据官网 /api/models 生成模型列表，并自动选择合适的模型名称。
- 支持智能识别思考链，并完美转换为下列三种格式
  - "think"
    - 将 `<details>` 元素替换为 `<think>` 元素，并去除 Markdown 引用块（`>`）
    - `<think>\n\n> 嗯，用户……\n\n</think>\n\n你好！`
  - "pure"
    - 去除 `<details>` 标签
    - `> 嗯，用户……\n\n你好！`
  - "raw"
    - 重构为 `<details><div>` 标签，显示英文思考时间
    - `<details type="reasoning" open><div>\n\n嗯，用户……\n\n</div><summary>Thought for 1 seconds</summary></details>\n\n你好！`
- **支持 OpenAI 标准认证**: 可通过环境变量 `API_KEY` 设置外部调用时的认证密钥

## 环境变量配置
- `API_KEY`: 外部调用API时使用的认证密钥 (可选，如不设置则跳过认证)
- `PORT`: 服务端口 (默认: 8080)
- `MODEL_NAME`: 默认模型名称 (默认: GLM-4.5)
- `DEBUG_MODE`: 调试模式 (默认: True)
- `THINK_TAGS_MODE`: 思考链处理模式 (默认: think)
- `ANON_TOKEN_ENABLED`: 是否启用访客模式 (默认: True)

## 使用
```bash
git clone https://github.com/hmjz100/Z.ai2api.git
cd Z.ai2api
pip install -r requirements.txt
python app.py
```

### 使用 Docker
```bash
# 不启用认证
docker run -p 8080:8080 z.ai2api

# 启用认证
docker run -p 8080:8080 -e API_KEY=sk-your-secret-key z.ai2api
```

### API 认证
当设置了 `API_KEY` 环境变量时，所有 API 端点都需要在请求头中包含认证信息：

```bash
curl -X POST "http://localhost:8080/v1/chat/completions" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer sk-your-secret-key" \
  -d '{"messages": [{"role": "user", "content": "Hello"}], "model": "GLM-4.5"}'
```
