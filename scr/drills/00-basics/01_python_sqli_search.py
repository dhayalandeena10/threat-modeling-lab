"""
users_api.py — Flask API for an internal employee directory search tool.
"""

import sqlite3
from flask import Flask, request, jsonify

app = Flask(__name__)
DB_PATH = "directory.db"


def get_db():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn


@app.route("/users/search")
def search_users():
    """Search users by name substring, e.g. /users/search?name=jane"""
    name = request.args.get("name", "")
    conn = get_db()
    query = "SELECT id, name, email, department FROM users WHERE name LIKE '%" + name + "%'"
    rows = conn.execute(query).fetchall()
    conn.close()
    return jsonify([dict(r) for r in rows])


@app.route("/users/<int:user_id>")
def get_user(user_id):
    """Fetch a single user by numeric ID."""
    conn = get_db()
    row = conn.execute(
        "SELECT id, name, email, department FROM users WHERE id = ?",
        (user_id,),
    ).fetchone()
    conn.close()
    if row is None:
        return jsonify({"error": "not found"}), 404
    return jsonify(dict(row))


@app.route("/users/by-department")
def users_by_department():
    """Filter users by department, e.g. /users/by-department?dept=eng"""
    dept = request.args.get("dept", "")
    allowed_depts = {"eng", "sales", "hr", "finance", "legal"}
    if dept not in allowed_depts:
        return jsonify({"error": "unknown department"}), 400
    conn = get_db()
    query = "SELECT id, name, email, department FROM users WHERE department = ?"
    rows = conn.execute(query, (dept,)).fetchall()
    conn.close()
    return jsonify([dict(r) for r in rows])


@app.route("/users/export")
def export_users():
    """Export the full directory, sorted by a caller-chosen column."""
    sort_col = request.args.get("sort", "name")
    valid_columns = {"id", "name", "email", "department"}
    if sort_col not in valid_columns:
        sort_col = "name"
    conn = get_db()
    query = f"SELECT id, name, email, department FROM users ORDER BY {sort_col}"
    rows = conn.execute(query).fetchall()
    conn.close()
    return jsonify([dict(r) for r in rows])


if __name__ == "__main__":
    app.run(debug=False)
