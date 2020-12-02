/*
 * accel.h
 *
 *  Created on: 1 dic. 2020
 *      Author: andys
 */

#ifndef ACCEL_H_
#define ACCEL_H_

#include "fsl_fxos.h"

uint8_t Get_Accel(uint8_t* Data);
void InitAccel(void);

#endif /* ACCEL_H_ */
