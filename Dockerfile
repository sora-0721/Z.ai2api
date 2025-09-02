FROM python:3.13

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# 环境变量配置
# API_KEY: 外部调用API时使用的认证密钥 (可选，如不设置则跳过认证)
# PORT: 服务端口 (默认: 8080)
# MODEL_NAME: 默认模型名称 (默认: GLM-4.5)
# DEBUG_MODE: 调试模式 (默认: True)
# THINK_TAGS_MODE: 思考链处理模式 (默认: think)
# ANON_TOKEN_ENABLED: 是否启用访客模式 (默认: True)

EXPOSE 8080

CMD ["python", "app.py"]
