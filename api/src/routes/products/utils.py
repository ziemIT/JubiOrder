def get_http_method(event):
    response = event.get("http", {}).get("method", None) or event.get("httpMethod", None)
    if not response:
        raise ValueError("""
            Couldn't parse the event. 
            Any known HTTP Method field not found.
            """
        )
    return response
