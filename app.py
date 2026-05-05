from flask import Flask, render_template, request, redirect
import mysql.connector
import os

app = Flask(__name__)

# DATABASE CONNECTION
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="191815",
    database="placement_portal"
)

# HOME
@app.route('/')
def home():
    return render_template("index.html")

# REGISTER
@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        password = request.form['password']

        cursor = db.cursor()
        cursor.execute(
            "INSERT INTO student(name,email,password) VALUES(%s,%s,%s)",
            (name, email, password)
        )
        db.commit()
        cursor.close()

        return redirect('/login')

    return render_template("register.html")

# LOGIN
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']

        cursor = db.cursor()
        cursor.execute(
            "SELECT * FROM student WHERE email=%s AND password=%s",
            (email, password)
        )
        user = cursor.fetchone()
        cursor.close()

        if user:
            return redirect('/dashboard')

    return render_template("login.html")

# DASHBOARD
@app.route('/dashboard')
def dashboard():
    return render_template("dashboard.html")

# QUIZ PAGE
@app.route('/quiz')
def quiz():
    cursor = db.cursor()
    cursor.execute("SELECT * FROM questions ORDER BY RAND() LIMIT 10")
    data = cursor.fetchall()
    cursor.close()

    return render_template("quiz.html", questions=data)

# SUBMIT QUIZ
@app.route('/submit_quiz', methods=['POST'])
def submit_quiz():

    cursor = db.cursor()
    cursor.execute("SELECT * FROM questions ORDER BY RAND() LIMIT 10")
    questions = cursor.fetchall()
    cursor.close()

    score = 0
    total = len(questions)

    for q in questions:
        qid = str(q[0])
        correct_answer = str(q[6]).strip()
        user_ans = request.form.get("q" + qid)

        if user_ans and user_ans.strip() == correct_answer:
            score += 1

    percent = (score / total) * 100

    if percent < 40:
        suggestion = """
1. Practice aptitude basics daily.
2. Improve speed in calculations.
3. Revise formulas regularly.
4. Solve 10 questions daily.
5. Stay confident.
"""
    elif percent < 70:
        suggestion = """
1. Good progress.
2. Practice timed mock tests.
3. Improve reasoning section.
4. Learn shortcut methods.
5. Improve communication skills.
"""
    else:
        suggestion = """
1. Excellent performance.
2. Maintain speed and accuracy.
3. Focus on company-specific tests.
4. Prepare HR interview.
5. Keep practicing.
"""

    return render_template(
        "result.html",
        score=score,
        total=total,
        suggestion=suggestion
    )

# COMPANIES
@app.route('/companies')
def companies():
    cursor = db.cursor()
    cursor.execute("SELECT * FROM companies")
    data = cursor.fetchall()
    cursor.close()

    return render_template("companies.html", companies=data)

# COMPANY DETAIL
@app.route('/company/<int:id>')
def company_detail(id):
    cursor = db.cursor()
    cursor.execute("SELECT * FROM companies WHERE id=%s", (id,))
    data = cursor.fetchone()
    cursor.close()

    return render_template("company_detail.html", company=data)

# INTERVIEW PAGE (IMPORTANT)
@app.route('/interview')
def interview():
    cursor = db.cursor()
    cursor.execute("SELECT * FROM interview_questions")
    data = cursor.fetchall()
    cursor.close()

    return render_template("interview.html", questions=data)

# CHECK ANSWER
@app.route('/check_answer', methods=['POST'])
def check_answer():

    question = request.form['question']
    user_answer = request.form['user_answer']

    if len(user_answer) < 20:
        feedback = """
1. Answer is too short.
2. Add more details.
3. Explain confidently.
4. Give examples.
5. Maintain eye contact.
"""
    elif len(user_answer) < 60:
        feedback = """
1. Good attempt.
2. Add stronger examples.
3. Improve confidence.
4. Use professional words.
5. Keep answer structured.
"""
    else:
        feedback = """
1. Very good answer.
2. Professional structure.
3. Good confidence.
4. Well explained.
5. Maintain same style.
"""

    return render_template(
        "answer.html",
        question=question,
        user_answer=user_answer,
        feedback=feedback
    )

@app.route('/profile')
def profile():
    return render_template("profile.html")


@app.route('/logout')
def logout():
    return redirect('/login')

@app.route('/resume', methods=['GET', 'POST'])
def resume():

    result = ""

    if request.method == 'POST':

        file = request.files['resume']

        if file:
            text = file.read().decode("utf-8")

            skills = ["Python", "Java", "SQL", "HTML", "CSS", "Flask", "C++"]

            found = []
            missing = []

            for skill in skills:
                if skill.lower() in text.lower():
                    found.append(skill)
                else:
                    missing.append(skill)

            score = len(found) * 10 + 30

            result = f"""
Skills Found: {', '.join(found)}

Missing Skills: {', '.join(missing)}

Resume Score: {score}/100

Suggestions:
1. Add more technical skills
2. Add projects section
3. Add internships/certifications
4. Improve summary section
5. Keep resume one page
"""

    return render_template("resume.html", result=result)

@app.route('/performance')
def performance():

    # Example real scores
    scores = [5, 7, 8, 6, 9]

    total_tests = len(scores)
    average = round(sum(scores) / total_tests, 2)
    highest = max(scores)
    lowest = min(scores)
    latest = scores[-1]
    first = scores[0]

    # Improvement check
    if latest > first:
        trend = "Improving"
    elif latest < first:
        trend = "Declining"
    else:
        trend = "Stable"

    # Performance status
    if average >= 8:
        status = "Excellent"
        readiness = 90
    elif average >= 6:
        status = "Good Progress"
        readiness = 75
    else:
        status = "Needs Improvement"
        readiness = 50

    # AI Suggestions
    suggestions = []

    if average < 6:
        suggestions.append("Practice aptitude basics daily.")
        suggestions.append("Focus on speed and accuracy.")
    else:
        suggestions.append("Maintain consistency.")
        suggestions.append("Attempt advanced mock tests.")

    if trend == "Declining":
        suggestions.append("Your recent scores dropped. Revise weak topics.")
    elif trend == "Improving":
        suggestions.append("Great progress. Keep practicing regularly.")

    suggestions.append("Prepare interview communication skills.")
    suggestions.append("Update resume for placements.")

    return render_template(
        "performance.html",
        scores=scores,
        average=average,
        highest=highest,
        lowest=lowest,
        trend=trend,
        status=status,
        readiness=readiness,
        suggestions=suggestions
    )

# RUN APP
if __name__ == "__main__":
    app.run(debug=True)