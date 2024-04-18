#!/bin/bash

echo -n "Enter the title: "
read POST_TITLE

echo -n "Enter the category: "
read CATEGORY

echo -n "Enter the short description: "
read DESCRIPTION

FORMATTED_TITLE=$(echo $POST_TITLE | sed -e 's/ /-/g')

DATE=$(date +%Y-%m-%d)

FILE_NAME="_posts/$DATE-$FORMATTED_TITLE.md"

mkdir -p _posts

echo "---" > $FILE_NAME
echo "title: \"$POST_TITLE\"" >> $FILE_NAME
echo "excerpt: \"$DESCRIPTION\"" >> $FILE_NAME
echo "" >> $FILE_NAME
echo "categories:" >> $FILE_NAME
echo "  - $CATEGORY" >> $FILE_NAME
echo "tags:" >> $FILE_NAME
echo "  - []" >> $FILE_NAME
echo ""  >> $FILE_NAME
if [ "$CATEGORY" = "C++" ]; then
	CATEGORY="cpp"
fi
LOWERCASE_CATEGORY=$(echo "$CATEGORY" | tr '[:upper:]' '[:lower:]')
echo "permalink: /categories/$LOWERCASE_CATEGORY/$FORMATTED_TITLE/" >> $FILE_NAME
echo "" >> $FILE_NAME
echo "toc: true" >> $FILE_NAME
echo "toc_sticky: true" >> $FILE_NAME
echo "" >> $FILE_NAME
echo "date: $DATE" >> $FILE_NAME
echo "last_modified_at: $DATE" >> $FILE_NAME
echo "---" >> $FILE_NAME

echo "The post '$POST_TITLE' has been created as $FILE_NAME"