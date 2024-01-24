//
//  UserTraining.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 02/11/22.
//

import Foundation


struct UserTraining: Decodable {
  let trainingUUID: String
  let offset: String?
  let start, end, trainingType, deviceType: String
  let groupalMode, processed: Int
  let summaries: Summaries
  let rewards: Rewards
  
  enum CodingKeys: String, CodingKey {
    case trainingUUID = "training_uuid"
    case offset, start, end
    case trainingType = "training_type"
    case deviceType = "device_type"
    case groupalMode = "groupal_mode"
    case processed, summaries, rewards
  }
}

struct Rewards: Codable {
    let caloriesPoints: String

    enum CodingKeys: String, CodingKey {
        case caloriesPoints = "calories_points"
    }
}

// MARK: - Summaries
struct Summaries: Codable {
    let z0TimeTot, durationTimeTot, z1TimeTot, z2TimeTot: String?
    let z3TimeTot, z4TimeTot, z5TimeTot, heartRateMin: String?
    let heartRateAvg, heartRateMax, effortMin, effortAvg: String?
    let effortMax, caloriesTot, z1CaloriesTot, z2CaloriesTot: String?
    let z3CaloriesTot, z4CaloriesTot, z5CaloriesTot, stepsTot: String?
    let z1StepsTot, z2StepsTot, z3StepsTot, z4StepsTot: String?
    let z5StepsTot, cadenceMin, cadenceAvg, cadenceMax: String?
    let z1CadenceAvg, z2CadenceAvg, z3CadenceAvg, z4CadenceAvg: String?
    let z5CadenceAvg: String?

    enum CodingKeys: String, CodingKey {
        case z0TimeTot = "z0_time_tot"
        case durationTimeTot = "duration_time_tot"
        case z1TimeTot = "z1_time_tot"
        case z2TimeTot = "z2_time_tot"
        case z3TimeTot = "z3_time_tot"
        case z4TimeTot = "z4_time_tot"
        case z5TimeTot = "z5_time_tot"
        case heartRateMin = "heart_rate_min"
        case heartRateAvg = "heart_rate_avg"
        case heartRateMax = "heart_rate_max"
        case effortMin = "effort_min"
        case effortAvg = "effort_avg"
        case effortMax = "effort_max"
        case caloriesTot = "calories_tot"
        case z1CaloriesTot = "z1_calories_tot"
        case z2CaloriesTot = "z2_calories_tot"
        case z3CaloriesTot = "z3_calories_tot"
        case z4CaloriesTot = "z4_calories_tot"
        case z5CaloriesTot = "z5_calories_tot"
        case stepsTot = "steps_tot"
        case z1StepsTot = "z1_steps_tot"
        case z2StepsTot = "z2_steps_tot"
        case z3StepsTot = "z3_steps_tot"
        case z4StepsTot = "z4_steps_tot"
        case z5StepsTot = "z5_steps_tot"
        case cadenceMin = "cadence_min"
        case cadenceAvg = "cadence_avg"
        case cadenceMax = "cadence_max"
        case z1CadenceAvg = "z1_cadence_avg"
        case z2CadenceAvg = "z2_cadence_avg"
        case z3CadenceAvg = "z3_cadence_avg"
        case z4CadenceAvg = "z4_cadence_avg"
        case z5CadenceAvg = "z5_cadence_avg"
    }
}
