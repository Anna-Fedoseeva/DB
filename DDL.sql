CREATE TABLE Passengers (
    ID SERIAL PRIMARY KEY,
    Surname VARCHAR(64) NOT NULL,
    Name VARCHAR(64) NOT NULL,
    Patronymic VARCHAR(64),
    Date_of_birth DATE NOT NULL,
    Passport NUMERIC(10) NOT NULL
);

CREATE TABLE Tickets (
    ID SERIAL PRIMARY KEY,
    Row NUMERIC(40) NOT NULL,
    Place VARCHAR(6) NOT NULL,
    Cost NUMERIC(11) NOT NULL,
    Flight_link INTEGER,
    Passenger_link INTEGER,
    FOREIGN KEY (Flight_link) REFERENCES Flights(ID),
    FOREIGN KEY (Passenger_link) REFERENCES Passengers(ID)
);

CREATE TABLE Flights (
    ID SERIAL PRIMARY KEY,
    Flight_number NUMERIC(40) NOT NULL,
    Direction_from VARCHAR(64) NOT NULL,
    Direction_to VARCHAR(64) NOT NULL,
    Company_id INTEGER,
    Departure_date DATE NOT NULL,
    FOREIGN KEY (Company_id) REFERENCES Companies(ID)
);

CREATE TABLE Companies (
    ID SERIAL PRIMARY KEY,
    Company_name VARCHAR(64) NOT NULL,
    Airplane_type VARCHAR(64) NOT NULL
);

CREATE TABLE Companies_history (
    ID SERIAL PRIMARY KEY,
    Company_id NUMERIC(40),
    Start_valid DATE,
    End_valid DATE NOT NULL,
    Company_name VARCHAR(64) NOT NULL,
    FOREIGN KEY (Company_id) REFERENCES Companies(ID)
);

CREATE TABLE Sales_statistics (
    ID SERIAL PRIMARY KEY,
    Flight_id NUMERIC(40),
    Start_valid DATE,
    Average_ticket_price NUMERIC(40),
    Minimum_ticket_price NUMERIC(40),
    Maximum_ticket_price NUMERIC(40),
    FOREIGN KEY (Flight_id) REFERENCES Flights(ID)
);
