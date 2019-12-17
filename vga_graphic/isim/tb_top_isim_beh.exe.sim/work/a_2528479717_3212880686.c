/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/SharedVmchine/NDI_mask_meng/vga_graphic/cntr.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_1242562249;

unsigned char ieee_p_1242562249_sub_1781507893_1035706684(char *, char *, char *, int );
char *ieee_p_1242562249_sub_1919365254_1035706684(char *, char *, char *, char *, int );
unsigned char ieee_p_1242562249_sub_2110375371_1035706684(char *, char *, char *, char *, char *);
unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_2528479717_3212880686_p_0(char *t0)
{
    char t16[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned char t8;
    unsigned char t9;
    unsigned char t10;
    int t11;
    unsigned char t12;
    char *t13;
    char *t14;
    char *t17;
    char *t18;
    int t19;
    unsigned int t20;
    unsigned char t21;
    char *t22;
    char *t23;
    char *t24;
    unsigned int t25;

LAB0:    xsi_set_current_line(38, ng0);
    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 992U);
    t4 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t4 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    xsi_set_current_line(50, ng0);
    t1 = (t0 + 2088U);
    t2 = *((char **)t1);
    t1 = (t0 + 3536);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t13 = *((char **)t7);
    memcpy(t13, t2, 11U);
    xsi_driver_first_trans_fast_port(t1);
    t1 = (t0 + 3392);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(39, ng0);
    t1 = xsi_get_transient_memory(11U);
    memset(t1, 0, 11U);
    t5 = t1;
    memset(t5, (unsigned char)2, 11U);
    t6 = (t0 + 2088U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    memcpy(t6, t1, 11U);
    xsi_set_current_line(40, ng0);
    t1 = (t0 + 3472);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB3;

LAB5:    xsi_set_current_line(42, ng0);
    t2 = (t0 + 2088U);
    t6 = *((char **)t2);
    t2 = (t0 + 5404U);
    t11 = (1040 - 1);
    t12 = ieee_p_1242562249_sub_1781507893_1035706684(IEEE_P_1242562249, t6, t2, t11);
    if (t12 == 1)
        goto LAB13;

LAB14:    t7 = (t0 + 2088U);
    t13 = *((char **)t7);
    t7 = (t0 + 5404U);
    t14 = (t0 + 5446);
    t17 = (t16 + 0U);
    t18 = (t17 + 0U);
    *((int *)t18) = 0;
    t18 = (t17 + 4U);
    *((int *)t18) = 10;
    t18 = (t17 + 8U);
    *((int *)t18) = 1;
    t19 = (10 - 0);
    t20 = (t19 * 1);
    t20 = (t20 + 1);
    t18 = (t17 + 12U);
    *((unsigned int *)t18) = t20;
    t21 = ieee_p_1242562249_sub_2110375371_1035706684(IEEE_P_1242562249, t13, t7, t14, t16);
    t10 = t21;

LAB15:    if (t10 != 0)
        goto LAB10;

LAB12:    xsi_set_current_line(46, ng0);
    t1 = (t0 + 2088U);
    t2 = *((char **)t1);
    t1 = (t0 + 5404U);
    t5 = ieee_p_1242562249_sub_1919365254_1035706684(IEEE_P_1242562249, t16, t2, t1, 1);
    t6 = (t0 + 2088U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    t13 = (t16 + 12U);
    t20 = *((unsigned int *)t13);
    t25 = (1U * t20);
    memcpy(t6, t5, t25);
    xsi_set_current_line(47, ng0);
    t1 = (t0 + 3472);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);

LAB11:    goto LAB3;

LAB7:    t2 = (t0 + 1192U);
    t5 = *((char **)t2);
    t8 = *((unsigned char *)t5);
    t9 = (t8 == (unsigned char)3);
    t3 = t9;
    goto LAB9;

LAB10:    xsi_set_current_line(43, ng0);
    t18 = xsi_get_transient_memory(11U);
    memset(t18, 0, 11U);
    t22 = t18;
    memset(t22, (unsigned char)2, 11U);
    t23 = (t0 + 2088U);
    t24 = *((char **)t23);
    t23 = (t24 + 0);
    memcpy(t23, t18, 11U);
    xsi_set_current_line(44, ng0);
    t1 = (t0 + 3472);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB11;

LAB13:    t10 = (unsigned char)1;
    goto LAB15;

}


extern void work_a_2528479717_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2528479717_3212880686_p_0};
	xsi_register_didat("work_a_2528479717_3212880686", "isim/tb_top_isim_beh.exe.sim/work/a_2528479717_3212880686.didat");
	xsi_register_executes(pe);
}
