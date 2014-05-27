 
  extensions [ gis array table ]
     
__includes [      
   
  "nls_files/setup_households.nls"  
  "nls_files/violence.nls"                    
  "nls_files/police_call.nls"                  
    
  
  "nls_files/setup_gis.nls"                      
  "nls_files/main_methods.nls"                 
  "nls_files/input_data.nls"                   
  "nls_files/shelter_methods.nls"              
  "nls_files/leaving_abuser.nls"               
          

  "nls_files/become_homeless.nls"              
  "nls_files/friend_help.nls"                 

  "nls_files/job_calculation.nls"              
  "nls_files/general_methods.nls"              
  "nls_files/update_plots.nls"                 
    
  "nls_files/setup_services_data.nls"          
  "nls_files/setup-coefficients.nls"           
  "nls_files/social_center_methods.nls"        
  "nls_files/world_conversion.nls"        

  ]
   
  breed [ households household ]               
  breed [ shelters shelter ]
  breed [ welfare-places welfare-place ]   

to setup
    
  ;; (for this model to work with NetLogo's new plotting features,
  ;; __clear-all-and-reset-ticks should be replaced with clear-all at
  ;; the beginning of your setup procedure and reset-ticks at the end
  ;; of the procedure.)
  __clear-all-and-reset-ticks
 
  setup-gis-data  
  
  read-setup-services-file "data/centers.csv"
  
  read-setup-shelters-file "data/shelters.csv"  
  
  load-in-households-and-people "data/households.csv" "data/population.csv" 
  
  setup-all-initial-household-and-person-data
  
  reset-ticks
  
end
 
to go
  
  reset-time
  
  reset-variables
  
  run-all-main-methods 
     
  update-all-plots
 
  tick
 
end
@#$#@#$#@
GRAPHICS-WINDOW
389
10
946
896
156
244
1.75
1
1
1
1
1
0
0
0
1
-156
156
-244
244
1
1
0
ticks
30.0

MONITOR
240
10
290
55
Years
year-count
1
1
11

PLOT
5
241
361
414
Annual police calls
years
per 1,000
0.0
10.0
0.0
7.0
true
true
"" ""
PENS
"Average total" 1.0 0 -16777216 true "" ""
"Average for White" 1.0 0 -13345367 true "" ""
"Average for Black" 1.0 0 -2674135 true "" ""
"Average for Hispanic" 1.0 0 -10899396 true "" ""

CHOOSER
6
463
179
508
Shelter-status
Shelter-status
"original capacity" "decreased capacity" "increased capacity"
0

SLIDER
6
514
178
547
Percent-of-shelter-capacity
Percent-of-shelter-capacity
0
500
200
1
1
NIL
HORIZONTAL

SLIDER
6
423
178
456
change-public-awareness
change-public-awareness
0
100
1
1
1
NIL
HORIZONTAL

SWITCH
182
423
361
456
change-public-awareness?
change-public-awareness?
0
1
-1000

PLOT
6
66
361
240
Annual incident rate by race
years
per 1,000
0.0
10.0
0.0
30.0
true
true
"" ""
PENS
"Average total" 1.0 0 -16777216 true "" ""
"Average for White" 1.0 0 -13345367 true "" ""
"Average for Black" 1.0 0 -2674135 true "" ""
"Average for Hispanic" 1.0 0 -10899396 true "" ""

SLIDER
185
464
361
497
cultural-sensitivity
cultural-sensitivity
0
100
97
1
1
NIL
HORIZONTAL

MONITOR
291
10
341
55
Months
month-count
17
1
11

BUTTON
10
10
74
43
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
79
10
176
43
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

CHOOSER
178
661
387
706
Variable-to-Display
Variable-to-Display
"isHurtPhysically?" "isHurtInjuriously?" "receivedInformalSupport?" "foundChildCare?" "foundFinAid?" "foundHouseAid?" "foundHomelessAid?" "victimCalledPolice?" "lowIncomeMomFoundJob?" "talkedToFriend?" "currentlyInShelter?" "gotService?" "leftAbuser?" "isHomeless?" "visitedShelter?" "visitedServiceLocation?" "foundEducService?" "currentlySafe?"
0

BUTTON
279
709
387
742
NIL
Update-Map
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

@#$#@#$#@
## PURPOSE

The purpose of the model is to evaluate the effectiveness of such parameters as cultural sensitivity, public awareness, and the number of shelter beds on IPV rates among non-Hispanic White, African American, and Hispanic women by income level in Chicago, Illinois. The model demonstrates the discrepancy between officially reported violence incidents and those experienced in reality. This model explores the state changes of a set of IPV at a point in time until those IPV events are resolved. This is done to more accurately reflect the research literature on IPV. Figure 1 demonstrates the conceptual relationships in the model.

## STATE VARIABLES AND SCALES

The model was developed using NetLogo 4.1 (Wilensky 1999). The model area is the City of Chicago represented by a map of census tracts mapped onto a 90 meter grid. Each tract contains information on its racial composition by accounting the percentage of African American, non-Hispanic White, and Hispanic individuals. A part of Chicago�s social support system is represented by 60 community service centers with the following variables: availability of ESL and GED classes, childcare, financial, and housing assistance. The model operates on a monthly time step. For the results reported here, the model was run for 10 years.

The model contains two types of agents: individual humans and shelters. Major attributes for humans include the following variables derived from the 2008 American Community Survey (ACS): age, gender, race, ethnicity, personal income, household income, type of a household, educational attainment, school enrollment, English speaking ability, number of children, age of children, vehicle, poverty status, relationship to the head of the household, public assistance (food stamps), and the date of when a person moved to a household. Additional attributes are described in the section 3.7 and the data for these variables have been derived from the literature. The model uses one percent of Chicago�s population over the age of 15 produced by the Digital Populations software on the basis of ACS (Ehlschlaeger 2004). Digital Populations geo-located all households based on land use, and census tract information. Married or cohabiting African American, non-Hispanic White, and Hispanic women are a targeted sample of interest.

Shelters are the second element of the social support system. Since the model is representing 100 people as one agent, the number of shelter beds is similarly reduced to two. The model uses two shelters with one bed in each. One shelter is located in a Hispanic tract and another one in a racially mixed tract. The choice of these locations was random.

## PROCESS OVERVIEW AND SCHEDULING

Each sampled woman may experience violence at any time step. It is assumed that each battered woman wants to reduce or stop violence by means of becoming more economically independent (e.g., having a higher income) or by means of leaving the relationship if the violence continues. Once a woman experiences violence, she can do any combination of the following: call police, disclose abuse to friends (disclosure of abuse is assumed to be equal to asking for help), leave the relationship, go to a shelter or a community center, become homeless and return back to the relationship. 
   
Women living at or below the poverty level will search for a job and are considered capable of living apart from their abuser when their income reaches $16,640 . The job search is not directly triggered by exposure to violence, but the probability of becoming employed is influenced by violence. If a woman has not found a job and she has a low educational attainment, or bad English skills, or is in need of childcare she may go to a community center in search of these services.

Other processes include the willingness of a woman�s friends to assist in response for her request for help and the provision of services by shelters.
        

## ADAPTATION

It is assumed that each battered woman�s goal is to leave the relationship. As income is inversely related to the probability of violence, women at or below the poverty level want to obtain a job and reach income of $16,640. Searching for education and/or childcare in community centers is a direct adaptive trait in order to increase employability. In general, searching for employment and higher income is an indirect adaptive trait since it may either help a woman to decrease the violence or to become financially independent and leave the relationship. 

## SENSING

It is assumed that women know about shelters and their location but they do not know which shelter has available spots. Women also know about community centers but have no information about specific services. The information about location and services is not kept in memory. 

## INTERACTION

Women can ask friends for help and friends may or may not provide assistance. Women do not keep track of friends who refused to help them.    
Women also interact with shelters and community centers by requesting services. Indirectly, they interact with other battered women when they compete for a shelter bed.

## STOCHASTICITY

The model is primarily stochastic. It uses stochasticity:   
a)	As an input value with a mean and a standard deviation to the logistic regression equations in order to represent the variability of reality.   
b)	As a decision-making process by comparing the results of a random number generator and the logistic regression equations in order to represent the uncertainty in women�s decisions. 

Stochasticity is a vital characteristic to the model due to the unpredictability of human behaviour in general, and a variety of decisions that can be made in the uncertainty of IPV context in particular.  

## OBSERVATION

Model results are collected from the number of incidents and police calls (represented as a rate per 1,000 of target population) and the percentage of battered women who left the relationship by race/ethnicity and income level (above and below the poverty level).

## INITIALIZATION

The model starts by initializing the geographic space. Next, shelters and community centers are created and followed by initialization of one percent sample of Chicago�s population. Each married or cohabiting African American, non-Hispanic White, and Hispanic woman over the age of 15 is assigned an at risk of domestic violence status. None of the women are assigned any personal exposure to violence and the shelters are empty. As the model runs, it takes about 5 time steps to fill the shelters up.   
The variables are read from the input files, or created using random numbers. The model does not use a seed, so the same parameters will produce different results. At the end of the initialization, the racial composition of the tracts is calculated by summing up all individuals within the tract boundary and dividing it by the total population.

## INPUT

The model�s inputs include an ESRI shapefile to determine Chicago�s boundary, a raster file of census tracts with a 90 meter resolution, and population data produced with the Digital Populations software. Each person is placed in geographic space according to the coordinates generated by Digital Populations and contains variables discussed above.  
For the data obtained from the literature, the values are assigned using a random number generator. Percentages are treated as probabilities � for example, if 5% of non-Hispanic White females over the age of 45 have alcohol problems, each simulated 45+ non-Hispanic White female has that chance of alcohol problem.   
Data on the location and available services in shelters and community centers are collected from the websites of corresponding agencies.  

## SUBMODELS

EXPERIENCING VIOLENCE. The probability of violence occurring in an intimate partnership is calculated based on a logistic regression developed by Salari and Baldwin (2002). Salari and Baldwin (2002) distinguish between verbal, physical, and injurious violence, but the model omits verbal violence. The probability depends on such variables as household income, woman�s income, presence of a child under the age of five, official marriage status (vs. cohabiting), relationship duration, number of shared friends in a couple, race/ethnicity, number of personal friends, adherence to traditional gender roles, availability of informal support in a crisis, alcohol problems, and a level of self-esteem for each partner. These variables are either drawn from ACS information of the simulated households or stochastically derived based on research on those social variables. If violence happens, it is assumed to be equal to one act. Exposure to violence is one of the inputs into calling police, receiving help from friends, leaving the relationship, and looking for a job.
       

## CALLING POLICE.

This procedure is triggered by exposure to violence and is calculated on the basis of a logistic regression developed by Felson and Pare (2005). It depends on such variables as a reporting person�s age, education, income, race/ethnicity, and whether the violence was initiated by a partner (vs. a stranger), at home (vs. on a street), and resulted in a physical injury. It is assumed that violence always happens at home. Calls made to police are recorded for each woman on a yearly basis and represent official statistics reported to the authorities.
    
## DISCLOSING ABUSE TO FRIENDS.

This procedure is assumed to be equal to a request for any help and is calculated for every woman who has experienced violence during the simulation. Using a non-representative sample, Yoshioka et al. (2003) and West et al. (1998) reported the percentages of women, by race and ethnicity, that are willing to discuss abuse with friends, with the model stochastically determining which abused women do so. A friend to be contacted is chosen randomly. 

## RECEIVING HELP FROM FRIENDS.

The procedure is triggered if a woman contacted one of the friends and is calculated on the basis of a logistic regression developed by Beeble et al. (2008). It evaluates the willingness of an individual to provide any kind of support and depends on such variables as a person�s gender, age, attitudes and beliefs about violence, perceived prevalence of violence rates in the community, and childhood and personal exposure to violence. The result is one of the inputs into experiencing violence and leaving the relationship. Public awareness (PA) is one of the dependent variables and includes the level of willingness to disclose abuse to friends and the level of attitudes and beliefs about violence and perceived prevalence of violence rates in the community. 

## LEAVING THE RELATIONSHIP.

The model calculates this procedure for each woman that has ever experienced violence on the basis of a logistic regression developed by Sabina and Tindale (2008). It depends on such variables as a yearly number of violent acts, the level of the most severe incident, harassment, power and control, health and depression, education, income, availability of social support, and type of employment. 

bEING HOMELESS.  
A woman�s status is updated to homeless if she left the relationship and her income is below $16,640. During the homelessness period, a woman attempts to stay at a shelter (a temporary solution) or goes to a community center for housing assistance (a permanent solution). A woman is allowed to stay homeless for up to a year. If she does not find housing assistance or a job during this period she returns to the abusive relationship.

## SEARCHING FOR SHELTERS.

This procedure is triggered in two cases: when a woman left the relationship and when she is homeless. First, the probability of making a decision to go to a shelter depends on a woman�s income and is assumed to be 0.6 for women below and 0.4 for women above poverty level . The probability of making an actual visit depends on a physical distance, woman�s race/ethnicity, and the racial composition of a tract where a shelter is located.

The racial/ethnic composition of each census tract is defined on the basis of Turner and Hayes (1997): predominantly Black tracts are those where more than 50% of the population is African American; predominantly White tracts are those with less than 10% of African Americans and less than 10% of Hispanics; mixed tracts are those where African American population is between 10 and 50%; and Hispanic tracts are those with less than 10% of African Americans and more than 10% of Hispanics. It has been suggested that minority women are less likely to use services located outside of their neighborhoods (Donnelly et al. 2005) and hence the assumption is that the racial composition of a tract where a shelter is located does not match a woman�s race she will be less willing to use this service.
    

A woman gets accepted if a shelter has available beds. Otherwise, she moves to the next shelter. Women at or below poverty level are allowed to stay at a shelter for a maximum available time. The length of stay for more affluent women is determined by drawing a random number between one month and the maximum available time.
        

## LOOKING FOR A JOB.

This procedure is calculated for each woman who is at or below 100% of federal poverty level on the basis of a logistic regression developed by Blumenberg (2002). It depends on such variables as education, English speaking ability, ownership of a personal car, health problems including injuries inflicted during exposure to violence, and presence of children who need childcare.

Searching for services in community centers. This procedure is triggered in two cases: when a woman is homeless and searches for housing assistance and when she did not find a job and searches for GED or ESL classes or childcare. A woman selects community centers within a distance of three kilometers and evaluates the probability of visiting. Each service is coded as 1 if present and 0 if absent. If the function returns true with a given probability, a woman moves to the community center and checks for the services of interest. If no services are available she selects the next block of community centers within the search distance.   

## SIMULATION EXPERIMENTS

A total of 100 runs were performed to test the effect of the number of shelter beds at 100% and 200% increase, and the level of CS and PA at 50% and 100% increase in comparison with existing conditions (represented as 0% increase in the subsequent Tables). The results were averaged for each experiment over 10 years of simulations. 
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

house bungalow
false
0
Rectangle -7500403 true true 210 75 225 255
Rectangle -7500403 true true 90 135 210 255
Rectangle -16777216 true false 165 195 195 255
Line -16777216 false 210 135 210 255
Rectangle -16777216 true false 105 202 135 240
Polygon -7500403 true true 225 150 75 150 150 75
Line -16777216 false 75 150 225 150
Line -16777216 false 195 120 225 150
Polygon -16777216 false false 165 195 150 195 180 165 210 195
Rectangle -16777216 true false 135 105 165 135

house colonial
false
0
Rectangle -7500403 true true 270 75 285 255
Rectangle -7500403 true true 45 135 270 255
Rectangle -16777216 true false 124 195 187 256
Rectangle -16777216 true false 60 195 105 240
Rectangle -16777216 true false 60 150 105 180
Rectangle -16777216 true false 210 150 255 180
Line -16777216 false 270 135 270 255
Polygon -7500403 true true 30 135 285 135 240 90 75 90
Line -16777216 false 30 135 285 135
Line -16777216 false 255 105 285 135
Line -7500403 true 154 195 154 255
Rectangle -16777216 true false 210 195 255 240
Rectangle -16777216 true false 135 150 180 180

house efficiency
false
0
Rectangle -7500403 true true 180 90 195 195
Rectangle -7500403 true true 90 165 210 255
Rectangle -16777216 true false 165 195 195 255
Rectangle -16777216 true false 105 202 135 240
Polygon -7500403 true true 225 165 75 165 150 90
Line -16777216 false 75 165 225 165

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

person graduate
false
0
Circle -16777216 false false 39 183 20
Polygon -1 true false 50 203 85 213 118 227 119 207 89 204 52 185
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 79 172 94
Polygon -8630108 true false 90 19 150 37 210 19 195 4 105 4
Polygon -8630108 true false 120 90 105 90 60 195 90 210 120 165 90 285 105 300 195 300 210 285 180 165 210 210 240 195 195 90
Polygon -1184463 true false 135 90 120 90 150 135 180 90 165 90 150 105
Line -2674135 false 195 90 150 135
Line -2674135 false 105 90 150 135
Polygon -1 true false 135 90 150 105 165 90
Circle -1 true false 104 205 20
Circle -1 true false 41 184 20
Circle -16777216 false false 106 206 18
Line -2674135 false 208 22 208 57

person service
false
0
Polygon -7500403 true true 180 195 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285
Polygon -1 true false 120 90 105 90 60 195 90 210 120 150 120 195 180 195 180 150 210 210 240 195 195 90 180 90 165 105 150 165 135 105 120 90
Polygon -1 true false 123 90 149 141 177 90
Rectangle -7500403 true true 123 76 176 92
Circle -7500403 true true 110 5 80
Line -13345367 false 121 90 194 90
Line -16777216 false 148 143 150 196
Rectangle -16777216 true false 116 186 182 198
Circle -1 true false 152 143 9
Circle -1 true false 152 166 9
Rectangle -16777216 true false 179 164 183 186
Polygon -2674135 true false 180 90 195 90 183 160 180 195 150 195 150 135 180 90
Polygon -2674135 true false 120 90 105 90 114 161 120 195 150 195 150 135 120 90
Polygon -2674135 true false 155 91 128 77 128 101
Rectangle -16777216 true false 118 129 141 140
Polygon -2674135 true false 145 91 172 77 172 101

person student
false
0
Polygon -13791810 true false 135 90 150 105 135 165 150 180 165 165 150 105 165 90
Polygon -7500403 true true 195 90 240 195 210 210 165 105
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -1 true false 100 210 130 225 145 165 85 135 63 189
Polygon -13791810 true false 90 210 120 225 135 165 67 130 53 189
Polygon -1 true false 120 224 131 225 124 210
Line -16777216 false 139 168 126 225
Line -16777216 false 140 167 76 136
Polygon -7500403 true true 105 90 60 195 90 210 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

police
false
0
Circle -7500403 false true 45 45 210
Polygon -7500403 true true 96 225 150 60 206 224 63 120 236 120
Polygon -7500403 true true 120 120 195 120 180 180 180 185 113 183
Polygon -7500403 false true 30 15 0 45 15 60 30 90 30 105 15 165 3 209 3 225 15 255 60 270 75 270 99 256 105 270 120 285 150 300 180 285 195 270 203 256 240 270 255 270 285 255 294 225 294 210 285 165 270 105 270 90 285 60 300 45 270 15 225 30 210 30 150 15 90 30 75 30

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.0RC3
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="experiment" repetitions="1" runMetricsEveryStep="true">
    <setup>Setup
rut</setup>
    <go>Chicago-GO</go>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="center-capacity">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="change-public-awareness">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cultural-sensitivity">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="change-public-awareness?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Center-status">
      <value value="&quot;original capacity&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Percent-of-shelter-capacity">
      <value value="200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Shelter-status">
      <value value="&quot;original capacity&quot;"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
