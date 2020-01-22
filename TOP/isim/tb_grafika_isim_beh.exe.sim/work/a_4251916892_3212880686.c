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
static const char *ng0 = "C:/SharedVmchine/NDI_mask_meng/TOP/Grafika/graphic_rom.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_1242562249;

int ieee_p_1242562249_sub_1657552908_1035706684(char *, char *, char *);
unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_4251916892_3212880686_p_0(char *t0)
{
    char t4[16];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned char t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;

LAB0:    xsi_set_current_line(2099, ng0);

LAB3:    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t1 = (t0 + 1672U);
    t3 = *((char **)t1);
    t5 = ((IEEE_P_2592010699) + 4024);
    t6 = (t0 + 8192U);
    t7 = (t0 + 8160U);
    t1 = xsi_base_array_concat(t1, t4, t5, (char)97, t2, t6, (char)97, t3, t7, (char)101);
    t8 = (4U + 12U);
    t9 = (16U != t8);
    if (t9 == 1)
        goto LAB5;

LAB6:    t10 = (t0 + 5040);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t1, 16U);
    xsi_driver_first_trans_fast(t10);

LAB2:    t15 = (t0 + 4928);
    *((int *)t15) = 1;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    xsi_size_not_matching(16U, t8, 0);
    goto LAB6;

}

static void work_a_4251916892_3212880686_p_1(char *t0)
{
    char t4[16];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned char t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;

LAB0:    xsi_set_current_line(2100, ng0);

LAB3:    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t1 = (t0 + 1832U);
    t3 = *((char **)t1);
    t5 = ((IEEE_P_2592010699) + 4024);
    t6 = (t0 + 8208U);
    t7 = (t0 + 8176U);
    t1 = xsi_base_array_concat(t1, t4, t5, (char)97, t2, t6, (char)97, t3, t7, (char)101);
    t8 = (4U + 12U);
    t9 = (16U != t8);
    if (t9 == 1)
        goto LAB5;

LAB6:    t10 = (t0 + 5104);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t1, 16U);
    xsi_driver_first_trans_fast(t10);

LAB2:    t15 = (t0 + 4944);
    *((int *)t15) = 1;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    xsi_size_not_matching(16U, t8, 0);
    goto LAB6;

}

static void work_a_4251916892_3212880686_p_2(char *t0)
{
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    unsigned char t8;
    unsigned char t9;
    char *t10;
    char *t11;
    int t12;
    int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;

LAB0:    xsi_set_current_line(2104, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 4960);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(2105, ng0);
    t3 = (t0 + 1352U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t6 = (t5 == (unsigned char)3);
    if (t6 != 0)
        goto LAB5;

LAB7:
LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(2106, ng0);
    t3 = (t0 + 1192U);
    t7 = *((char **)t3);
    t8 = *((unsigned char *)t7);
    t9 = (t8 == (unsigned char)3);
    if (t9 != 0)
        goto LAB8;

LAB10:
LAB9:    xsi_set_current_line(2109, ng0);
    t1 = (t0 + 2632U);
    t3 = *((char **)t1);
    t1 = (t0 + 2792U);
    t4 = *((char **)t1);
    t1 = (t0 + 8288U);
    t12 = ieee_p_1242562249_sub_1657552908_1035706684(IEEE_P_1242562249, t4, t1);
    t13 = (t12 - 0);
    t14 = (t13 * 1);
    xsi_vhdl_check_range_of_index(0, 65535, 1, t12);
    t15 = (2U * t14);
    t16 = (0 + t15);
    t7 = (t3 + t16);
    t10 = (t0 + 5232);
    t11 = (t10 + 56U);
    t17 = *((char **)t11);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memcpy(t19, t7, 2U);
    xsi_driver_first_trans_fast_port(t10);
    xsi_set_current_line(2110, ng0);
    t1 = (t0 + 2632U);
    t3 = *((char **)t1);
    t1 = (t0 + 2952U);
    t4 = *((char **)t1);
    t1 = (t0 + 8288U);
    t12 = ieee_p_1242562249_sub_1657552908_1035706684(IEEE_P_1242562249, t4, t1);
    t13 = (t12 - 0);
    t14 = (t13 * 1);
    xsi_vhdl_check_range_of_index(0, 65535, 1, t12);
    t15 = (2U * t14);
    t16 = (0 + t15);
    t7 = (t3 + t16);
    t10 = (t0 + 5296);
    t11 = (t10 + 56U);
    t17 = *((char **)t11);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memcpy(t19, t7, 2U);
    xsi_driver_first_trans_fast_port(t10);
    goto LAB6;

LAB8:    xsi_set_current_line(2107, ng0);
    t3 = (t0 + 1512U);
    t10 = *((char **)t3);
    t3 = (t0 + 2792U);
    t11 = *((char **)t3);
    t3 = (t0 + 8288U);
    t12 = ieee_p_1242562249_sub_1657552908_1035706684(IEEE_P_1242562249, t11, t3);
    t13 = (t12 - 0);
    t14 = (t13 * 1);
    t15 = (2U * t14);
    t16 = (0U + t15);
    t17 = (t0 + 5168);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t10, 2U);
    xsi_driver_first_trans_delta(t17, t16, 2U, 0LL);
    goto LAB9;

}


extern void work_a_4251916892_3212880686_init()
{
	static char *pe[] = {(void *)work_a_4251916892_3212880686_p_0,(void *)work_a_4251916892_3212880686_p_1,(void *)work_a_4251916892_3212880686_p_2};
	xsi_register_didat("work_a_4251916892_3212880686", "isim/tb_grafika_isim_beh.exe.sim/work/a_4251916892_3212880686.didat");
	xsi_register_executes(pe);
}
