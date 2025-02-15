using DifferentialEquations, Plots, NLsolve

# Parameters
const beta = 0.98    # Discount factor
const sigma = 2.0    # Risk aversion
const phi = 1.0      # Labor supply elasticity
const alpha = 0.36   # Capital share in production
const delta = 0.025  # Depreciation rate
const theta = 0.8    # Loan-to-value ratio (collateral constraint)
const rho_G = 0.9    # Government spending persistence
const G_bar = 0.2    # Steady-state government spending
const phi_pi = 1.5   # Monetary policy response to inflation
const phi_Y = 0.5    # Monetary policy response to output
const gamma_s = 0.5  # Precautionary savings response to austerity
const gamma_r = 0.3  # Risk premium sensitivity to default rate
const default_rate_base = 0.02 # Baseline firm default rate

# Define the differential system
function austerity_bank_lending!(du, u, p, t)
    # State Variables
    C, K, L, Y, I, B, Q, G, Pi, R, S, LendRate = u
    
    # Exogenous Productivity
    A = 1.0  

    # Austerity Shock: Negative shock to G
    epsilon_G = -0.02
    G_new = (1 - rho_G) * G_bar + rho_G * G + epsilon_G

    # Production Function
    Y_new = A * K^alpha * L^(1 - alpha)

    # Investment Equation
    I_new = delta * K

    # Capital Price (Q falls when G decreases)
    Q_new = 0.9 * Q + 0.1 * (Y_new / K) 

    # Inflation Dynamics
    Pi_new = 0.9 * Pi + 0.1 * (Y_new - Y)

    # Taylor Rule (Monetary Policy)
    R_new = 1.0 + phi_pi * (Pi_new - 0.02) + phi_Y * (Y_new - Y)

    # **Savings Channel**: Households increase savings (S) when uncertainty rises (G falls)
    S_new = S + gamma_s * (G_bar - G_new)

    # **Risk Premium Channel**: Banks raise lending rate when defaults rise
    default_rate = default_rate_base + (G_bar - G_new) * 0.05  # Higher defaults when G falls
    LendRate_new = 1.0 + gamma_r * default_rate

    # **Collateral Constraint**: Borrowing (B) depends on capital value (Q) and interest rate (R)
    B_new = theta * Q_new * K * exp(-R_new - LendRate_new)

    # Consumption (decreases as savings increase)
    C_new = Y_new - I_new - G_new - S_new

    # System of differential equations
    du[1] = C_new - C  # Consumption change
    du[2] = K - K  # Capital unchanged
    du[3] = L - L  # Labor unchanged
    du[4] = Y_new - Y  # Output change
    du[5] = I_new - I  # Investment change
    du[6] = B_new - B  # Credit falls with austerity
    du[7] = Q_new - Q  # Collateral value falls
    du[8] = G_new - G  # Austerity shock
    du[9] = Pi_new - Pi  # Inflation update
    du[10] = R_new - R  # Interest rate
    du[11] = S_new - S  # Savings increase
    du[12] = LendRate_new - LendRate  # Risk premium increases
end

# Initial conditions (Steady State)
u0 = [1.0, 5.0, 1.0, 1.0, 0.1, 0.5, 1.0, G_bar, 0.02, 1.0, 0.5, 1.0]  
# S = 0.5 (Initial Savings), LendRate = 1.0 (Baseline Lending Rate)

# Solve the differential system
tspan = (0.0, 20.0)
prob = ODEProblem(austerity_bank_lending!, u0, tspan)
sol = solve(prob, Tsit5())

# Plot results
plot(sol.t, sol[6,:], xlabel="Time", ylabel="Credit (B_t)", title="Impact of Austerity on Credit", label="Borrowing")
plot(sol.t, sol[11,:], xlabel="Time", ylabel="Savings (S_t)", title="Precautionary Savings Increase under Austerity", label="Savings")
plot(sol.t, sol[12,:], xlabel="Time", ylabel="Lending Rate (R_L)", title="Risk Premium on Loans Increases under Austerity", label="Lending Rate")
plot(sol.t, sol[7,:], xlabel="Time", ylabel="Collateral Value (Q_t)", title="Austerity Reduces Collateral Value", label="Collateral Value")