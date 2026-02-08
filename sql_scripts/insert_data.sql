-- Insert Customers
INSERT INTO Customers VALUES (101, 'Uwera Claudine', 'Individual', 'Savings', 'Kigali', TO_DATE('2021-01-10', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (102, 'Mugisha Andrew', 'Individual', 'Current', 'Kigali', TO_DATE('2021-02-15', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (103, 'Inyumba Alice', 'Individual', 'Savings', 'Northern', TO_DATE('2021-03-20', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (104, 'Kamanzi David', 'Corporate', 'Current', 'Kigali', TO_DATE('2020-11-05', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (105, 'Mukeshimana Grace', 'Individual', 'Fixed Deposit', 'Southern', TO_DATE('2021-04-12', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (106, 'TechHub Ltd', 'Corporate', 'Current', 'Kigali', TO_DATE('2020-09-18', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (107, 'Nkusi Patrick', 'Individual', 'Savings', 'Western', TO_DATE('2021-05-22', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (108, 'Umutoni Sarah', 'Individual', 'Current', 'Eastern', TO_DATE('2021-06-08', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (109, 'AgriCoop Rwanda', 'Corporate', 'Current', 'Southern', TO_DATE('2020-12-14', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (110, 'Habimana Eric', 'Individual', 'Savings', 'Northern', TO_DATE('2021-07-19', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (111, 'Uwase Marie', 'Individual', 'Fixed Deposit', 'Kigali', TO_DATE('2021-08-03', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (112, 'BuildCo Ltd', 'Corporate', 'Current', 'Western', TO_DATE('2020-10-25', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (113, 'Ngoga Joseph', 'Individual', 'Savings', 'Eastern', TO_DATE('2021-09-11', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (114, 'Mukamana Diane', 'Individual', 'Current', 'Southern', TO_DATE('2021-10-16', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (115, 'Bizimana Frank', 'Individual', 'Savings', 'Northern', TO_DATE('2021-11-21', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (116, 'Ingabire Alice', 'Individual', 'Current', 'Kigali', TO_DATE('2022-01-07', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (117, 'HealthPlus Clinic', 'Corporate', 'Current', 'Kigali', TO_DATE('2020-08-30', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (118, 'Rugamba Emmanuel', 'Individual', 'Savings', 'Western', TO_DATE('2022-02-14', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (119, 'Murekatete Christine', 'Individual', 'Fixed Deposit', 'Eastern', TO_DATE('2022-03-19', 'YYYY-MM-DD'));
INSERT INTO Customers VALUES (120, 'Ndayisaba Jean', 'Individual', 'Savings', 'Southern', TO_DATE('2022-04-25', 'YYYY-MM-DD'));


-- Insert Branches
INSERT INTO Branches VALUES (1, 'Kigali City Branch', 'Kigali', 'Jean Mukasa', TO_DATE('2020-01-15', 'YYYY-MM-DD'));
INSERT INTO Branches VALUES (2, 'Nyarugenge Branch', 'Kigali', 'Grace Uwase', TO_DATE('2020-03-10', 'YYYY-MM-DD'));
INSERT INTO Branches VALUES (3, 'Gasabo Branch', 'Kigali', 'Patrick Nkusi', TO_DATE('2021-02-20', 'YYYY-MM-DD'));
INSERT INTO Branches VALUES (4, 'Musanze Branch', 'Northern', 'Alice Ingabire', TO_DATE('2019-11-05', 'YYYY-MM-DD'));
INSERT INTO Branches VALUES (5, 'Gicumbi Branch', 'Northern', 'Eric Habimana', TO_DATE('2020-06-12', 'YYYY-MM-DD'));
INSERT INTO Branches VALUES (6, 'Rubavu Branch', 'Western', 'Marie Umutoni', TO_DATE('2020-08-22', 'YYYY-MM-DD'));
INSERT INTO Branches VALUES (7, 'Karongi Branch', 'Western', 'David Mugisha', TO_DATE('2021-01-18', 'YYYY-MM-DD'));
INSERT INTO Branches VALUES (8, 'Rusizi Branch', 'Western', 'Sarah Nikuze', TO_DATE('2019-09-30', 'YYYY-MM-DD'));
INSERT INTO Branches VALUES (9, 'Huye Branch', 'Southern', 'Emmanuel Ndayisaba', TO_DATE('2020-04-14', 'YYYY-MM-DD'));
INSERT INTO Branches VALUES (10, 'Muhanga Branch', 'Southern', 'Christine Murekatete', TO_DATE('2020-10-08', 'YYYY-MM-DD'));
INSERT INTO Branches VALUES (11, 'Nyanza Branch', 'Southern', 'Joseph Rugamba', TO_DATE('2021-03-25', 'YYYY-MM-DD'));
INSERT INTO Branches VALUES (12, 'Rwamagana Branch', 'Eastern', 'Beatrice Kayitesi', TO_DATE('2019-12-20', 'YYYY-MM-DD'));
INSERT INTO Branches VALUES (13, 'Kayonza Branch', 'Eastern', 'Robert Nsengimana', TO_DATE('2020-07-16', 'YYYY-MM-DD'));
INSERT INTO Branches VALUES (14, 'Ngoma Branch', 'Eastern', 'Diane Uwineza', TO_DATE('2021-05-11', 'YYYY-MM-DD'));
INSERT INTO Branches VALUES (15, 'Kirehe Branch', 'Eastern', 'Frank Bizimana', TO_DATE('2020-02-28', 'YYYY-MM-DD'));



-- Insert Transactions for 2024 (mix across all months)
-- October 2024
INSERT INTO Transactions VALUES (1001, 101, 1, TO_DATE('2024-10-05', 'YYYY-MM-DD'), 'Deposit', 500000);
INSERT INTO Transactions VALUES (1002, 102, 1, TO_DATE('2024-10-08', 'YYYY-MM-DD'), 'Withdrawal', 150000);
INSERT INTO Transactions VALUES (1003, 104, 2, TO_DATE('2024-10-10', 'YYYY-MM-DD'), 'Deposit', 2000000);
INSERT INTO Transactions VALUES (1004, 106, 3, TO_DATE('2024-10-12', 'YYYY-MM-DD'), 'Transfer', 1500000);
INSERT INTO Transactions VALUES (1005, 103, 4, TO_DATE('2024-10-15', 'YYYY-MM-DD'), 'Deposit', 300000);

-- November 2024
INSERT INTO Transactions VALUES (1006, 105, 9, TO_DATE('2024-11-03', 'YYYY-MM-DD'), 'Deposit', 800000);
INSERT INTO Transactions VALUES (1007, 107, 6, TO_DATE('2024-11-05', 'YYYY-MM-DD'), 'Withdrawal', 200000);
INSERT INTO Transactions VALUES (1008, 109, 10, TO_DATE('2024-11-08', 'YYYY-MM-DD'), 'Deposit', 3000000);
INSERT INTO Transactions VALUES (1009, 108, 12, TO_DATE('2024-11-10', 'YYYY-MM-DD'), 'Transfer', 400000);
INSERT INTO Transactions VALUES (1010, 110, 5, TO_DATE('2024-11-12', 'YYYY-MM-DD'), 'Deposit', 250000);
INSERT INTO Transactions VALUES (1011, 101, 1, TO_DATE('2024-11-15', 'YYYY-MM-DD'), 'Deposit', 600000);
INSERT INTO Transactions VALUES (1012, 112, 7, TO_DATE('2024-11-18', 'YYYY-MM-DD'), 'Deposit', 2500000);

-- December 2024
INSERT INTO Transactions VALUES (1013, 113, 13, TO_DATE('2024-12-02', 'YYYY-MM-DD'), 'Deposit', 350000);
INSERT INTO Transactions VALUES (1014, 114, 11, TO_DATE('2024-12-05', 'YYYY-MM-DD'), 'Withdrawal', 180000);
INSERT INTO Transactions VALUES (1015, 116, 2, TO_DATE('2024-12-07', 'YYYY-MM-DD'), 'Deposit', 450000);
INSERT INTO Transactions VALUES (1016, 117, 3, TO_DATE('2024-12-10', 'YYYY-MM-DD'), 'Transfer', 1800000);
INSERT INTO Transactions VALUES (1017, 104, 1, TO_DATE('2024-12-12', 'YYYY-MM-DD'), 'Deposit', 2200000);
INSERT INTO Transactions VALUES (1018, 106, 3, TO_DATE('2024-12-15', 'YYYY-MM-DD'), 'Deposit', 1600000);
INSERT INTO Transactions VALUES (1019, 109, 9, TO_DATE('2024-12-18', 'YYYY-MM-DD'), 'Deposit', 3200000);
INSERT INTO Transactions VALUES (1020, 112, 6, TO_DATE('2024-12-20', 'YYYY-MM-DD'), 'Transfer', 2800000);

-- January 2025
INSERT INTO Transactions VALUES (1021, 101, 1, TO_DATE('2025-01-05', 'YYYY-MM-DD'), 'Deposit', 700000);
INSERT INTO Transactions VALUES (1022, 118, 8, TO_DATE('2025-01-08', 'YYYY-MM-DD'), 'Deposit', 320000);
INSERT INTO Transactions VALUES (1023, 119, 14, TO_DATE('2025-01-10', 'YYYY-MM-DD'), 'Deposit', 900000);
INSERT INTO Transactions VALUES (1024, 120, 10, TO_DATE('2025-01-12', 'YYYY-MM-DD'), 'Withdrawal', 150000);
INSERT INTO Transactions VALUES (1025, 104, 2, TO_DATE('2025-01-15', 'YYYY-MM-DD'), 'Deposit', 2400000);
INSERT INTO Transactions VALUES (1026, 117, 1, TO_DATE('2025-01-18', 'YYYY-MM-DD'), 'Transfer', 1900000);
INSERT INTO Transactions VALUES (1027, 106, 3, TO_DATE('2025-01-20', 'YYYY-MM-DD'), 'Deposit', 1700000);
INSERT INTO Transactions VALUES (1028, 109, 11, TO_DATE('2025-01-22', 'YYYY-MM-DD'), 'Deposit', 3500000);
INSERT INTO Transactions VALUES (1029, 112, 7, TO_DATE('2025-01-25', 'YYYY-MM-DD'), 'Deposit', 3000000);
INSERT INTO Transactions VALUES (1030, 115, 5, TO_DATE('2025-01-28', 'YYYY-MM-DD'), 'Deposit', 280000);

COMMIT;
