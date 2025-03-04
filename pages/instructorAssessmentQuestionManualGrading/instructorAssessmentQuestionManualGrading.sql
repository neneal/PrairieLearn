-- BLOCK select_question
SELECT
    q.id AS question_id,
    q.title AS question_title,
    aq.max_points
FROM
    assessment_questions AS aq
    JOIN questions AS q ON (q.id = aq.question_id)
WHERE
    aq.assessment_id = $assessment_id
    AND aq.id = $assessment_question_id;


-- BLOCK select_instance_questions_manual_grading
SELECT DISTINCT ON (iq.id)
    iq.*,
    s.graded_at,
    ai.id AS assessment_instance_id,
    u.uid,
    u.name AS user_name
FROM
    instance_questions AS iq
    JOIN assessment_instances AS ai ON (ai.id = iq.assessment_instance_id)
    JOIN variants AS v ON (v.instance_question_id = iq.id)
    JOIN submissions s ON (s.variant_id = v.id)
    JOIN users u ON (u.user_id = ai.user_id)
WHERE
    ai.assessment_id = $assessment_id
    AND iq.assessment_question_id = $assessment_question_id
ORDER BY iq.id DESC, s.date DESC, s.id DESC;


-- BLOCK select_instance_questions_manual_grading_groups
SELECT DISTINCT ON (iq.id)
    iq.*,
    s.graded_at,
    ai.id AS assessment_instance_id,
    g.name AS group_name
FROM
    instance_questions AS iq
    JOIN assessment_instances AS ai ON (ai.id = iq.assessment_instance_id)
    JOIN variants AS v ON (v.instance_question_id = iq.id)
    JOIN submissions s ON (s.variant_id = v.id)
    JOIN groups g ON (g.id = ai.group_id)
WHERE
    ai.assessment_id = $assessment_id
    AND iq.assessment_question_id = $assessment_question_id
ORDER BY iq.id DESC, s.date DESC, s.id DESC;

