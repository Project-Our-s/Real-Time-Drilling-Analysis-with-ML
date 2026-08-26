--creating table--
CREATE TABLE drilling_data (
    time TIMESTAMP,

    block_position NUMERIC,
    weight_on_bit NUMERIC,
    hookload NUMERIC,
    slips_set NUMERIC,
    rop_depth_hour NUMERIC,
    mwd_gamma_api NUMERIC,
    on_bottom NUMERIC,

    top_drive_rpm NUMERIC,
    top_drive_torque_ft_lbs NUMERIC,

    flow_in NUMERIC,
    pump_pressure NUMERIC,
    spm_total NUMERIC,

    pit_volume_active NUMERIC,
    pit_gl_active NUMERIC,

    gas_total_units NUMERIC,

    trip_volume_active NUMERIC,
    trip_gl NUMERIC,

    return_flow NUMERIC,

    rig_mode NUMERIC,
    rockit_on_off NUMERIC,

    res_ps_2mhz_18in NUMERIC,
    res_ps_400khz_18in NUMERIC,

    mwd_inclination NUMERIC,
    mwd_azimuth NUMERIC,

    mud_temp NUMERIC,
    h2s_01 NUMERIC,

    rss_azimuth NUMERIC,
    rig_event_code NUMERIC,

    total_depth NUMERIC,
    bit_diameter NUMERIC,
    bit_rpm NUMERIC,

    depth_hole_tvd NUMERIC,

    differential_pressure NUMERIC,
    downhole_torque NUMERIC,

    drill_mode NUMERIC
);


--checking total records--
SELECT COUNT(*) AS total_records
FROM drilling_data;


--checking missing values--
SELECT
COUNT(*) FILTER (WHERE "weight_on_bit" IS NULL) AS wob_missing,
COUNT(*) FILTER (WHERE "pump_pressure" IS NULL) AS pressure_missing,
COUNT(*) FILTER (WHERE "rop_depth_hour" IS NULL) AS rop_missing,
COUNT(*) FILTER (WHERE "top_drive_torque_ft_lbs" IS NULL) AS torque_missing
FROM drilling_data;

--checking duplicate values of time --
SELECT COUNT(*) AS total_rows
FROM drilling_data;
SELECT COUNT(DISTINCT time) AS unique_timestamps
FROM drilling_data;

--checking invalid minimum values--
SELECT
    MIN(weight_on_bit) AS min_wob,
    MIN(rop_depth_hour) AS min_rop,
    MIN(pump_pressure) AS min_pressure,
    MIN(top_drive_torque_ft_lbs) AS min_torque,
    MIN(top_drive_rpm) AS min_rpm,
    MIN(flow_in) AS min_flow,
    MIN(hookload) AS min_hookload
FROM drilling_data;


--checking invalid maximum values--
SELECT
    MAX(weight_on_bit) AS max_wob,
    MAX(rop_depth_hour) AS max_rop,
    MAX(pump_pressure) AS max_pressure,
    MAX(top_drive_torque_ft_lbs) AS max_torque,
    MAX(top_drive_rpm) AS max_rpm,
    MAX(flow_in) AS max_flow,
    MAX(hookload) AS max_hookload
FROM drilling_data;


--checking data types--
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'drilling_data'
ORDER BY ordinal_position;


--Average Rate of Penetration (ROP)--
SELECT
    ROUND(AVG(rop_depth_hour), 2) AS average_rop
FROM drilling_data
WHERE rop_depth_hour IS NOT NULL;

--Average Pump Pressure--
SELECT
    ROUND(AVG(pump_pressure), 2) AS average_pump_pressure
FROM drilling_data
WHERE pump_pressure IS NOT NULL;

--Average Top Drive Torque--
SELECT
    ROUND(AVG(top_drive_torque_ft_lbs), 2) AS average_torque
FROM drilling_data
WHERE top_drive_torque_ft_lbs IS NOT NULL;

--Maximum Depth Reached--
SELECT
    MAX(total_depth) AS maximum_depth
FROM drilling_data;

--Rig Mode Frequency--
SELECT
    rig_mode,
    COUNT(*) AS frequency
FROM drilling_data
GROUP BY rig_mode
ORDER BY frequency DESC;

--Drill Mode Frequency--
SELECT
    drill_mode,
    COUNT(*) AS frequency
FROM drilling_data
GROUP BY drill_mode
ORDER BY frequency DESC;

--Daily Statistics--
SELECT
    DATE(time) AS drilling_date,
    ROUND(AVG(rop_depth_hour),2) AS average_rop,
    ROUND(AVG(pump_pressure),2) AS average_pressure,
    ROUND(AVG(top_drive_torque_ft_lbs),2) AS average_torque,
    MAX(total_depth) AS maximum_depth
FROM drilling_data
GROUP BY DATE(time)
ORDER BY drilling_date;

