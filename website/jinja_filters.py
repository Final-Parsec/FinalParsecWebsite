def pretty_date(date_of_occurrence):
    """
    Get a date and return a pretty string like 'Today', 'Yesterday', '3 months ago', '1 week ago', etc.
    """
    from datetime import date
    today = date.today()
    diff = today - date_of_occurrence
    day_diff = diff.days

    if day_diff < 0:
        return ''

    if day_diff == 0:
        return 'Today'
    if day_diff == 1:
        return "Yesterday"
    if day_diff < 7:
        return str(day_diff) + " days ago"
    if day_diff < 31:
        if day_diff / 7 == 1:
            return '1 week ago'
        return str(day_diff / 7) + " weeks ago"
    if day_diff < 365:
        if day_diff / 30 == 1:
            return '1 month ago'
        return str(day_diff / 30) + " months ago"

    if day_diff / 365 == 1:
            return '1 year ago'
    return str(day_diff / 365) + " years ago"