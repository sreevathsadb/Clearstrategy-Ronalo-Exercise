create or replace table "RONALDO"."PUBLIC"."RONALDO_CAREER_LOADING_TABLE"  (
    SHOT_ID_NUMBER number primary key,
    MATCH_ID number not null,
    DISTANCE_OF_SHOT number,
    POWER_OF_SHOT number,
    AREA_OF_SHOT number,
    SHOT_BASICS number,
    LOCATION_X float,
    LOCATION_Y float,
    REMAINING_MIN float,
    IS_GOAL number,
    timestamp DATE,
  constraint MATCH_ID foreign key (MATCH_ID) references "RONALDO"."PUBLIC"."DIM_MATCH_INFO" (MATCH_ID) not enforced,
  constraint SHOT_BASICS foreign key (SHOT_BASICS) references "RONALDO"."PUBLIC"."DIM_SHOT_BASICS" (pkey) not enforced,
  constraint AREA_OF_SHOT foreign key (AREA_OF_SHOT) references "RONALDO"."PUBLIC"."DIM_AREA_OF_SHOT" (pkey) not enforced
    );
//======================================================================================    

MERGE INTO "RONALDO"."PUBLIC"."RONALDO_CAREER_LOADING_TABLE"
using "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE"
ON "RONALDO"."PUBLIC"."RONALDO_CAREER_LOADING_TABLE".SHOT_ID_NUMBER = "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE".SHOT_ID_NUMBER
WHEN NOT matched THEN
  INSERT (SHOT_ID_NUMBER,
    MATCH_ID,
    DISTANCE_OF_SHOT,
    POWER_OF_SHOT,
    AREA_OF_SHOT,
    SHOT_BASICS,
    LOCATION_X,
    LOCATION_Y,
    REMAINING_MIN,
    IS_GOAL,
    timestamp)
  VALUES (
    "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE".SHOT_ID_NUMBER,
    "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE".MATCH_ID,
    "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE".DISTANCE_OF_SHOT,
    "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE".POWER_OF_SHOT,
    "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE".AREA_OF_SHOT,
    "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE".SHOT_BASICS,
    "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE".LOCATION_X,
    "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE".LOCATION_Y,
    "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE".REMAINING_MIN,
    "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE".IS_GOAL,
    to_date(CURRENT_TIMESTAMP)
  ); 


select * from "RONALDO"."PUBLIC"."RONALDO_CAREER_LANDING_TABLE"