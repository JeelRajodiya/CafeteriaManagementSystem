from flask import current_app as app





@app.route("/admin")
def admin_route():
    return "hi"
