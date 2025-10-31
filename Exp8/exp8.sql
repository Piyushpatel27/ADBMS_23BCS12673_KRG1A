--HARD LEVEL QUES

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    class INT
);

DO $$
BEGIN
    BEGIN
        INSERT INTO students(name, age, class) VALUES ('Supriya',16,8);
        INSERT INTO students(name, age, class) VALUES ('Rakshit',17,8);
        INSERT INTO students(name, age, class) VALUES ('Varun',19,9);

        RAISE NOTICE 'Transaction Successfully Done';

    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Transaction Failed..! Rolling back changes.';
            RAISE;  
    END;
END;
$$;

SELECT * FROM students;

----------------------------------WRONG DATA TYPE SCENARIO----------------------------------
BEGIN; 

SAVEPOINT sp1;
INSERT INTO students(name, age, class) VALUES ('Aarav',16,8);

SAVEPOINT sp2;
BEGIN
    INSERT INTO students(name, age, class) VALUES ('Rahul','wrong',9);  -- fails
EXCEPTION WHEN OTHER    S THEN
    RAISE NOTICE 'Failed to insert Rahul, rolling back to savepoint sp2';
    ROLLBACK TO SAVEPOINT sp2;
END;

INSERT INTO students(name, age, class) VALUES ('Sita',17,10);

COMMIT;