from glob import glob
from markdown import markdown
from os import path


CONTENT_DIRECTORY = '../../content/'
AUTHORS = {
    'Baer': 1,
    'Matt': 2,
    'TJ': 3
}

sql_file = open('v_4_0_content_migration.sql', 'w')

sql_file.write('-- delete from post_tag;\n')
sql_file.write('-- delete from post;\n')
sql_file.write('-- delete from tag;\n\n')

if __name__ == '__main__':
    for content_file in glob(path.join(CONTENT_DIRECTORY, '*.md')):
        # print "current file is: " + content_file

        raw_content = file(content_file)
        # print raw_content

        is_reading_attributes = True
        author = ''
        category = ''
        date = ''
        markdown_content = ''
        slug = ''
        summary = ''
        tags = ''
        title = ''
        status = ''

        for i, line in enumerate(raw_content):
            if not line.strip() or not is_reading_attributes:
                is_reading_attributes = False
                markdown_content += line
                continue

            attribute_name = line.split(':')[0]
            attribute_value = line.split(':')[1].strip()

            if attribute_name == 'Author':
                author = attribute_value
            elif attribute_name == 'Category':
                category = attribute_value
            elif attribute_name == 'Date':
                date = attribute_value
            elif attribute_name == 'Slug':
                slug = attribute_value
            elif attribute_name == 'Summary':
                summary = attribute_value
            elif attribute_name == 'Tags':
                tags = attribute_value
            elif attribute_name == 'title':
                title = attribute_value
            elif attribute_name == 'status':
                status = attribute_value
            else:
                print 'WTF' + attribute_name


        sql_file.write("insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('"
            + slug + \
            "','" + date + \
            "', '" + summary.replace("'", "''") + \
            "', '" + markdown_content.replace("'", "''") + \
            "', '" + title.replace("'", "''") + \
            "', " + ('1' if status == 'draft' else '0') + \
            ", " + str(AUTHORS[author]) + ");\n\n")

        sql_file.write('set @last_post_id  = LAST_INSERT_ID();\n\n')

        for tag in tags.split(', '):
            sql_file.write("insert ignore into tag(name) values('" + tag + "');\n")
            sql_file.write("select id into @tag_id from tag where name = '" + tag + "';\n")
            sql_file.write("insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);\n\n")