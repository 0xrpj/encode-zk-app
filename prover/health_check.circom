pragma circom 2.0.0;

template HealthCheck() {
    signal input is_full_body_checked_up; // Boolean: 0 if fully checked up, 1 otherwise
    signal input has_chronic_disease; // Boolean: 0 if no chronic disease, 1 otherwise
    signal input current_date; // Integer: encoded as YYYYMMDD
    signal input national_identity_number;

    signal output status;

    // Status Logic:
    // 0: Healthy (checked up and no chronic disease)
    // 1: Needs attention (either not fully checked up or has chronic disease)
    signal checked_up_status;
    checked_up_status <== 1 - is_full_body_checked_up;

    signal disease_status;
    disease_status <== 1 - has_chronic_disease;

    signal healthy;
    healthy <== checked_up_status * disease_status;

    status <== 1 - healthy; // 0 if healthy, 1 if needs attention
}

component main {public [current_date, national_identity_number]} = HealthCheck();