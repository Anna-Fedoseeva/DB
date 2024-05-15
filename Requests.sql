--заполнение статистики по средней стоимости билетов для каждого направления
INSERT INTO Sales_statistics (Flight_id, Start_valid, Average_ticket_price)
SELECT Flights.ID, CURRENT_DATE, AVG(Cost)
FROM Flights
JOIN Tickets ON Flights.ID = Tickets.Flight_link
GROUP BY Flights.ID;

--средняя стоимость билетов для каждого направления
SELECT Direction_from, Direction_to, AVG(Cost) AS Average_cost
FROM Flights
JOIN Tickets ON Flights.ID = Tickets.Flight_link
GROUP BY Direction_from, Direction_to;

--количество проданных билетов на каждый рейс
SELECT Flight_number, COUNT(*) AS Ticket_count
FROM Flights
JOIN Tickets ON Flights.ID = Tickets.Flight_link
GROUP BY Flight_number;

--средняя стоимость билетов для каждой авиакомпании
SELECT Company_name, AVG(Cost) AS Average_cost
FROM Companies
JOIN Flights ON Companies.ID = Flights.Company_id
JOIN Tickets ON Flights.ID = Tickets.Flight_link
GROUP BY Company_name;

--общий объем продаж билетов по каждой авиакомпании
SELECT Company_name, SUM(Cost) AS Total_sales
FROM Companies
JOIN Flights ON Companies.ID = Flights.Company_id
JOIN Tickets ON Flights.ID = Tickets.Flight_link
GROUP BY Company_name;

--количество рейсов для каждого направления, где более 10 проданных билетов
SELECT Direction_from, Direction_to, COUNT(*) AS Flight_count
FROM Flights
JOIN Tickets ON Flights.ID = Tickets.Flight_link
GROUP BY Direction_from, Direction_to
HAVING COUNT(*) > 10;

--заполнение статистики по максимальной стоимости билетов для каждого рейса
INSERT INTO Sales_statistics (Flight_id, Start_valid, Maximum_ticket_price)
SELECT Flights.ID, CURRENT_DATE, MAX(Tickets.Cost)
FROM Flights
JOIN Tickets ON Flights.ID = Tickets.Flight_link
GROUP BY Flights.ID;

--заполнение статистики по минимальной стоимости билетов для каждого рейса
INSERT INTO Sales_statistics (Flight_id, Start_valid, Minimum_ticket_price)
SELECT Flights.ID, CURRENT_DATE, MIN(Tickets.Cost)
FROM Flights
JOIN Tickets ON Flights.ID = Tickets.Flight_link
GROUP BY Flights.ID;

--информация о компаниях с наименьшей средней стоимостью билетов
SELECT Company_name, AVG(Cost) AS Average_cost
FROM Companies
JOIN Flights ON Companies.ID = Flights.Company_id
JOIN Tickets ON Flights.ID = Tickets.Flight_link
GROUP BY Company_name
ORDER BY AVG(Cost)
LIMIT 1;

--информация о пассажирах с билетами на самый дорогой рейс
SELECT *
FROM Passengers
WHERE ID IN (
    SELECT DISTINCT Passengers.ID
    FROM Passengers
    JOIN Tickets ON Passengers.ID = Tickets.Passenger_link
    JOIN Flights ON Tickets.Flight_link = Flights.ID
    WHERE Flights.ID = (
        SELECT ID
        FROM Flights
        ORDER BY Cost DESC
        LIMIT 1
    )
);
