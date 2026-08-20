# Key DAX Measures — Harmony Grove Dashboard

All measures live in a dedicated `_Measures` table, separate from the data tables, following standard Power BI modeling practice.

## Revenue

```dax
Total Revenue =
CALCULATE(
    SUM(payments[amount_naira]),
    payments[payment_status] IN {"Paid", "Partially Paid"}
)

Gross Revenue = SUM(payments[amount_naira])
```

## Tutor Retention & Churn

```dax
Tutor Retention Rate =
DIVIDE(
    CALCULATE(COUNTROWS(tutors), tutors[status] = "Active"),
    CALCULATE(COUNTROWS(tutors), ALL(tutors))
)

Tutors' Attrition Rate =
DIVIDE(
    COUNTROWS(tutors),
    CALCULATE(COUNTROWS(tutors), ALL(tutors[Attriton_flag]))
)
```

### Rating Bucket (calculated column on `tutors`)

```dax
Rating Bucket =
VAR AvgRating =
    CALCULATE(
        AVERAGE(bookings[client_rating]),
        bookings[client_rating] <> BLANK()
    )
RETURN
    SWITCH(
        TRUE(),
        AvgRating >= 4.5, "4.5 - 5.0",
        AvgRating >= 4.0, "4.0 - 4.49",
        AvgRating >= 3.5, "3.5 - 3.99",
        AvgRating >= 3.0, "3.0 - 3.49",
        AvgRating < 3.0, "Below 3.0",
        "No Ratings"
    )

Rating Bucket Sort Order =
SWITCH(
    tutors[Rating Bucket],
    "4.5 - 5.0", 1,
    "4.0 - 4.49", 2,
    "3.5 - 3.99", 3,
    "3.0 - 3.49", 4,
    "Below 3.0", 5,
    "No Ratings", 6,
    99
)

Churn Rate by Bucket =
DIVIDE(
    CALCULATE(COUNTROWS(tutors), tutors[status] = "Inactive"),
    CALCULATE(COUNTROWS(tutors), ALL(tutors[status]))
)
```

## Corporate Contract Utilization

```dax
Sessions Used =
CALCULATE(
    COUNTROWS(bookings),
    bookings[status] = "Completed",
    NOT ISBLANK(bookings[contract_id]),
    USERELATIONSHIP(bookings[contract_id], corporate_contracts[contract_id])
)

Contract Utilization Rate (Avg per Contract) =
AVERAGEX(
    corporate_contracts,
    DIVIDE(
        CALCULATE(
            COUNTROWS(bookings),
            bookings[status] = "Completed",
            USERELATIONSHIP(bookings[contract_id], corporate_contracts[contract_id])
        ),
        corporate_contracts[sessions_included]
    )
)
```

## Subscriptions

```dax
Subscription Renewal Rate =
DIVIDE(
    CALCULATE(COUNTROWS(subscriptions), subscriptions[renewed_flag] = TRUE),
    COUNTROWS(subscriptions)
)
```

## Client Engagement

```dax
Avg Bookings Per Client =
DIVIDE(
    CALCULATE(COUNTROWS(bookings), bookings[status] = "Completed"),
    DISTINCTCOUNT(bookings[client_id])
)
```

## Date Table

```dax
DateTable =
ADDCOLUMNS(
    CALENDAR(DATE(2022,1,1), DATE(2025,12,31)),
    "Year", YEAR([Date]),
    "Month Number", MONTH([Date]),
    "Month Name", FORMAT([Date], "MMMM"),
    "Quarter", "Q" & FORMAT([Date], "Q")
)
```
`Month Name` is sorted by `Month Number` via **Column tools → Sort by column** to display in calendar order rather than alphabetical order.

---

### Notes on modeling decisions

- `USERELATIONSHIP` is used throughout because several relationships (e.g., `bookings[contract_id]` → `corporate_contracts[contract_id]`) had to be created as **inactive**, since an indirect path already existed via `clients`. Power BI does not allow two active filter paths between the same two tables.
- `AVERAGEX` (not a plain column-based ratio) is used for contract utilization specifically to avoid a bug where per-row percentages were being summed instead of recalculated per filter context — a plain calculated column produced impossible totals above 100%.
