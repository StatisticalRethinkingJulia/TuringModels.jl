# ## Data

import CSV

using DataFrames
using TuringModels

data_path = joinpath(TuringModels.project_root, "data", "reedfrogs.csv")
df = CSV.read(data_path, DataFrame; delim=';');
@assert size(df) == (48, 5) ## hide
df.tank = 1:nrow(df)
df

# ## Model

using Turing

@model function reedfrogs(density, tank, surv, n)
    a_tank ~ filldist(Normal(0, 1.5), n)

    logitp = a_tank[tank]
    surv .~ BinomialLogit.(density, logitp)
end;

# ## Output

n = nrow(df)
model = reedfrogs(df.density, df.tank, df.surv, n)
chns = sample(model, NUTS(0.65), 1000)

# \defaultoutput{}

# ## Original output (Edition 1)

"""
             mean   sd  5.5% 94.5% n_eff Rhat
a_tank[1]   2.49 1.16  0.85  4.53  1079    1
a_tank[2]   5.69 2.75  2.22 10.89  1055    1
a_tank[3]   0.89 0.75 -0.23  2.16  1891    1
a_tank[4]   5.71 2.70  2.21 10.85   684    1
a_tank[5]   2.52 1.14  0.92  4.42  1640    1
a_tank[6]   2.49 1.13  0.94  4.52  1164    1
a_tank[7]   5.74 2.71  2.25 10.86   777    1
a_tank[8]   2.52 1.19  0.95  4.42  1000    1
a_tank[9]  -0.46 0.69 -1.62  0.55  2673    1
a_tank[10]  2.53 1.19  0.93  4.59  1430    1
a_tank[11]  0.93 0.72 -0.17  2.11  1387    1
a_tank[12]  0.47 0.74 -0.63  1.70  1346    1
a_tank[13]  0.91 0.76 -0.25  2.30  1559    1
a_tank[14]  0.00 0.66 -1.04  1.06  2085    1
a_tank[15]  2.50 1.19  0.95  4.40  1317    1
a_tank[16]  2.50 1.14  0.98  4.31  1412    1
a_tank[17]  3.49 1.12  1.94  5.49   945    1
a_tank[18]  2.59 0.75  1.50  3.81  1561    1
a_tank[19]  2.11 0.64  1.15  3.15  1712    1
a_tank[20]  6.40 2.57  3.11 11.04   996    1
a_tank[21]  2.59 0.74  1.54  3.93  1233    1
a_tank[22]  2.63 0.79  1.49  4.01  1184    1
a_tank[23]  2.64 0.83  1.45  4.13  1379    1
a_tank[24]  1.74 0.59  0.85  2.72  1736    1
a_tank[25] -1.19 0.45 -1.90 -0.50  2145    1
a_tank[26]  0.09 0.41 -0.53  0.78  2167    1
a_tank[27] -1.75 0.56 -2.65 -0.88  1666    1
a_tank[28] -0.58 0.43 -1.25  0.08  1567    1
a_tank[29]  0.08 0.39 -0.54  0.71  3053    1
a_tank[30]  1.43 0.49  0.66  2.24  2754    1
a_tank[31] -0.79 0.44 -1.50 -0.12  1299    1
a_tank[32] -0.42 0.41 -1.12  0.23  1661    1
a_tank[33]  3.84 1.08  2.31  5.70   808    1
a_tank[34]  3.00 0.85  1.83  4.36  1038    1
a_tank[35]  2.96 0.82  1.82  4.25  1578    1
a_tank[36]  2.14 0.55  1.31  3.08  1734    1
a_tank[37]  2.12 0.56  1.31  3.04  1131    1
a_tank[38]  6.72 2.62  3.45 11.44   706    1
a_tank[39]  2.95 0.73  1.85  4.08  1509    1
a_tank[40]  2.48 0.65  1.53  3.61  1731    1
a_tank[41] -2.15 0.57 -3.11 -1.29  1231    1
a_tank[42] -0.67 0.35 -1.22 -0.14  1444    1
a_tank[43] -0.54 0.35 -1.12  0.03  1776    1
a_tank[44] -0.43 0.34 -1.00  0.10  1735    1
a_tank[45]  0.54 0.36 -0.04  1.14  1376    1
a_tank[46] -0.67 0.34 -1.25 -0.15  1619    1
a_tank[47]  2.14 0.55  1.31  3.04  1916    1
a_tank[48] -0.06 0.35 -0.61  0.50  1932    1
""";
