#!/bin/sh

# 如果指定了工作目录，就切换到该目录
if [ ! -z "${INPUT_WORKDIR}" ]; then
    cd "${INPUT_WORKDIR}"
fi

# 设置默认值
TAG="${INPUT_TAG:-$(date +%Y%m%d%H%M%S)}"
TITLE="${INPUT_TITLE:-Release $TAG}"
NOTES="${INPUT_NOTES:-}"
BODY="${INPUT_BODY:-}"
DRAFT="${INPUT_DRAFT:-false}"
PRERELEASE="${INPUT_PRERELEASE:-false}"
TARGET="${INPUT_TARGET:-}"
GENERATE_NOTES="${INPUT_GENERATE_NOTES:-false}"
NOTES_FILE="${INPUT_NOTES_FILE:-}"
DISCUSSION_CATEGORY="${INPUT_DISCUSSION_CATEGORY:-}"
VERIFY_TAG="${INPUT_VERIFY_TAG:-false}"

# 构建命令
CMD="gh release create"

# 添加标签
CMD="$CMD $TAG"

# 添加标题
CMD="$CMD -t \"$TITLE\""

# 添加发布说明
if [ "$GENERATE_NOTES" = "true" ]; then
    CMD="$CMD --generate-notes"
elif [ ! -z "$NOTES" ]; then
    CMD="$CMD -n \"$NOTES\""
elif [ ! -z "$NOTES_FILE" ]; then
    CMD="$CMD -F \"$NOTES_FILE\""
fi

# 添加正文
if [ ! -z "$BODY" ]; then
    CMD="$CMD --notes \"$BODY\""
fi

# 设置为草稿
if [ "$DRAFT" = "true" ]; then
    CMD="$CMD --draft"
fi

# 设置为预发布
if [ "$PRERELEASE" = "true" ]; then
    CMD="$CMD --prerelease"
fi

# 设置目标分支或提交
if [ ! -z "$TARGET" ]; then
    CMD="$CMD --target \"$TARGET\""
fi

# 设置讨论分类
if [ ! -z "$DISCUSSION_CATEGORY" ]; then
    CMD="$CMD --discussion-category \"$DISCUSSION_CATEGORY\""
fi

# 验证标签
if [ "$VERIFY_TAG" = "true" ]; then
    CMD="$CMD --verify-tag"
fi

# 执行命令
eval $CMD