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
static const char *ng0 = "C:/SharedVmchine/NDI_mask_meng/TOP/Grafika/gui_decoder.vhd";
extern char *IEEE_P_1242562249;
extern char *IEEE_P_2592010699;

int ieee_p_1242562249_sub_1657552908_1035706684(char *, char *, char *);
char *ieee_p_1242562249_sub_180853171_1035706684(char *, char *, int , int );
unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_0984964813_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;

LAB0:    xsi_set_current_line(34, ng0);

LAB3:    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    t1 = (t0 + 10180U);
    t3 = ieee_p_1242562249_sub_1657552908_1035706684(IEEE_P_1242562249, t2, t1);
    t4 = (t0 + 6224);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = t3;
    xsi_driver_first_trans_fast(t4);

LAB2:    t9 = (t0 + 6096);
    *((int *)t9) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0984964813_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;

LAB0:    xsi_set_current_line(35, ng0);

LAB3:    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t1 = (t0 + 10196U);
    t3 = ieee_p_1242562249_sub_1657552908_1035706684(IEEE_P_1242562249, t2, t1);
    t4 = (t0 + 6288);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = t3;
    xsi_driver_first_trans_fast(t4);

LAB2:    t9 = (t0 + 6112);
    *((int *)t9) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0984964813_3212880686_p_2(char *t0)
{
    char t3[16];
    char *t1;
    unsigned char t2;
    char *t4;
    char *t5;
    int t6;
    int t7;
    int t8;
    int t9;
    char *t10;
    int t11;
    int t12;
    int t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t21;
    char *t23;
    char *t25;
    int t27;
    char *t28;
    int t30;
    char *t31;
    int t33;
    char *t34;
    int t36;
    char *t37;
    int t39;
    char *t40;
    int t42;
    char *t43;
    int t45;
    char *t46;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;

LAB0:    xsi_set_current_line(39, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 6128);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(41, ng0);
    t4 = (t0 + 3272U);
    t5 = *((char **)t4);
    t6 = *((int *)t5);
    t7 = (t6 + 4);
    t8 = xsi_vhdl_mod(t7, 64);
    t9 = (t8 * 64);
    t4 = (t0 + 3432U);
    t10 = *((char **)t4);
    t11 = *((int *)t10);
    t12 = xsi_vhdl_mod(t11, 64);
    t13 = (t9 + t12);
    t4 = ieee_p_1242562249_sub_180853171_1035706684(IEEE_P_1242562249, t3, t13, 12);
    t14 = (t0 + 6352);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t4, 12U);
    xsi_driver_first_trans_fast_port(t14);
    xsi_set_current_line(42, ng0);
    t1 = (t0 + 6416);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    *((unsigned char *)t14) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(43, ng0);
    t1 = (t0 + 6480);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    *((unsigned char *)t14) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(44, ng0);
    t1 = (t0 + 6544);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    *((unsigned char *)t14) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(45, ng0);
    t1 = (t0 + 6608);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    *((unsigned char *)t14) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(46, ng0);
    t1 = (t0 + 6480);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    *((unsigned char *)t14) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(47, ng0);
    t1 = (t0 + 6672);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    *((unsigned char *)t14) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(51, ng0);
    t1 = (t0 + 1192U);
    t4 = *((char **)t1);
    t1 = (t0 + 10423);
    t6 = xsi_mem_cmp(t1, t4, 6U);
    if (t6 == 1)
        goto LAB6;

LAB21:    t10 = (t0 + 10429);
    t7 = xsi_mem_cmp(t10, t4, 6U);
    if (t7 == 1)
        goto LAB7;

LAB22:    t15 = (t0 + 10435);
    t8 = xsi_mem_cmp(t15, t4, 6U);
    if (t8 == 1)
        goto LAB8;

LAB23:    t17 = (t0 + 10441);
    t9 = xsi_mem_cmp(t17, t4, 6U);
    if (t9 == 1)
        goto LAB9;

LAB24:    t19 = (t0 + 10447);
    t11 = xsi_mem_cmp(t19, t4, 6U);
    if (t11 == 1)
        goto LAB10;

LAB25:    t21 = (t0 + 10453);
    t12 = xsi_mem_cmp(t21, t4, 6U);
    if (t12 == 1)
        goto LAB11;

LAB26:    t23 = (t0 + 10459);
    t13 = xsi_mem_cmp(t23, t4, 6U);
    if (t13 == 1)
        goto LAB12;

LAB27:    t25 = (t0 + 10465);
    t27 = xsi_mem_cmp(t25, t4, 6U);
    if (t27 == 1)
        goto LAB13;

LAB28:    t28 = (t0 + 10471);
    t30 = xsi_mem_cmp(t28, t4, 6U);
    if (t30 == 1)
        goto LAB14;

LAB29:    t31 = (t0 + 10477);
    t33 = xsi_mem_cmp(t31, t4, 6U);
    if (t33 == 1)
        goto LAB15;

LAB30:    t34 = (t0 + 10483);
    t36 = xsi_mem_cmp(t34, t4, 6U);
    if (t36 == 1)
        goto LAB16;

LAB31:    t37 = (t0 + 10489);
    t39 = xsi_mem_cmp(t37, t4, 6U);
    if (t39 == 1)
        goto LAB17;

LAB32:    t40 = (t0 + 10495);
    t42 = xsi_mem_cmp(t40, t4, 6U);
    if (t42 == 1)
        goto LAB18;

LAB33:    t43 = (t0 + 10501);
    t45 = xsi_mem_cmp(t43, t4, 6U);
    if (t45 == 1)
        goto LAB19;

LAB34:
LAB20:    xsi_set_current_line(106, ng0);
    t1 = (t0 + 3432U);
    t4 = *((char **)t1);
    t6 = *((int *)t4);
    t7 = xsi_vhdl_mod(t6, 64);
    t1 = ieee_p_1242562249_sub_180853171_1035706684(IEEE_P_1242562249, t3, t7, 6);
    t5 = (t0 + 6800);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t1, 6U);
    xsi_driver_first_trans_fast_port(t5);
    xsi_set_current_line(107, ng0);
    t1 = (t0 + 1192U);
    t4 = *((char **)t1);
    t53 = (5 - 4);
    t54 = (t53 * 1U);
    t55 = (0 + t54);
    t1 = (t4 + t55);
    t5 = (t0 + 6864);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t1, 5U);
    xsi_driver_first_trans_fast_port(t5);
    xsi_set_current_line(108, ng0);
    t1 = (t0 + 6416);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    *((unsigned char *)t14) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(109, ng0);
    t1 = (t0 + 6544);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    *((unsigned char *)t14) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(110, ng0);
    t1 = (t0 + 6608);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    *((unsigned char *)t14) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(111, ng0);
    t1 = (t0 + 6480);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    *((unsigned char *)t14) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(112, ng0);
    t1 = (t0 + 6672);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    *((unsigned char *)t14) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);

LAB5:    goto LAB3;

LAB6:    xsi_set_current_line(53, ng0);
    t46 = (t0 + 10507);
    t48 = (t0 + 6736);
    t49 = (t48 + 56U);
    t50 = *((char **)t49);
    t51 = (t50 + 56U);
    t52 = *((char **)t51);
    memcpy(t52, t46, 4U);
    xsi_driver_first_trans_fast_port(t48);
    goto LAB5;

LAB7:    xsi_set_current_line(56, ng0);
    t1 = (t0 + 10511);
    t5 = (t0 + 6736);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t1, 4U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB5;

LAB8:    xsi_set_current_line(59, ng0);
    t1 = (t0 + 10515);
    t5 = (t0 + 6736);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t1, 4U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB5;

LAB9:    xsi_set_current_line(62, ng0);
    t1 = (t0 + 10519);
    t5 = (t0 + 6736);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t1, 4U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB5;

LAB10:    xsi_set_current_line(65, ng0);
    t1 = (t0 + 10523);
    t5 = (t0 + 6736);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t1, 4U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB5;

LAB11:    xsi_set_current_line(68, ng0);
    t1 = (t0 + 10527);
    t5 = (t0 + 6736);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t1, 4U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB5;

LAB12:    xsi_set_current_line(71, ng0);
    t1 = (t0 + 10531);
    t5 = (t0 + 6736);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t1, 4U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB5;

LAB13:    xsi_set_current_line(74, ng0);
    t1 = (t0 + 10535);
    t5 = (t0 + 6736);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t1, 4U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB5;

LAB14:    xsi_set_current_line(77, ng0);
    t1 = (t0 + 10539);
    t5 = (t0 + 6736);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t1, 4U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB5;

LAB15:    xsi_set_current_line(80, ng0);
    t1 = (t0 + 10543);
    t5 = (t0 + 6736);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t1, 4U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB5;

LAB16:    xsi_set_current_line(83, ng0);
    t1 = (t0 + 3272U);
    t4 = *((char **)t1);
    t6 = *((int *)t4);
    t7 = xsi_vhdl_mod(t6, 64);
    t1 = (t0 + 3432U);
    t5 = *((char **)t1);
    t8 = *((int *)t5);
    t9 = xsi_vhdl_mod(t8, 64);
    t11 = (t9 * 64);
    t12 = (t7 + t11);
    t1 = ieee_p_1242562249_sub_180853171_1035706684(IEEE_P_1242562249, t3, t12, 12);
    t10 = (t0 + 6352);
    t14 = (t10 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memcpy(t17, t1, 12U);
    xsi_driver_first_trans_fast_port(t10);
    xsi_set_current_line(84, ng0);
    t1 = (t0 + 10547);
    t5 = (t0 + 6736);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t1, 4U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB5;

LAB17:    xsi_set_current_line(87, ng0);
    t1 = (t0 + 3272U);
    t4 = *((char **)t1);
    t6 = *((int *)t4);
    t7 = xsi_vhdl_mod(t6, 64);
    t8 = (63 - t7);
    t1 = (t0 + 3432U);
    t5 = *((char **)t1);
    t9 = *((int *)t5);
    t11 = xsi_vhdl_mod(t9, 64);
    t12 = (t11 * 64);
    t13 = (t8 + t12);
    t1 = ieee_p_1242562249_sub_180853171_1035706684(IEEE_P_1242562249, t3, t13, 12);
    t10 = (t0 + 6352);
    t14 = (t10 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memcpy(t17, t1, 12U);
    xsi_driver_first_trans_fast_port(t10);
    xsi_set_current_line(88, ng0);
    t1 = (t0 + 10551);
    t5 = (t0 + 6736);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t1, 4U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB5;

LAB18:    xsi_set_current_line(91, ng0);
    t1 = (t0 + 3272U);
    t4 = *((char **)t1);
    t6 = *((int *)t4);
    t7 = xsi_vhdl_mod(t6, 64);
    t8 = (64 * t7);
    t1 = (t0 + 3432U);
    t5 = *((char **)t1);
    t9 = *((int *)t5);
    t11 = xsi_vhdl_mod(t9, 64);
    t12 = (63 - t11);
    t13 = (t8 + t12);
    t1 = ieee_p_1242562249_sub_180853171_1035706684(IEEE_P_1242562249, t3, t13, 12);
    t10 = (t0 + 6352);
    t14 = (t10 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memcpy(t17, t1, 12U);
    xsi_driver_first_trans_fast_port(t10);
    xsi_set_current_line(92, ng0);
    t1 = (t0 + 10555);
    t5 = (t0 + 6736);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t1, 4U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB5;

LAB19:    xsi_set_current_line(95, ng0);
    t1 = xsi_get_transient_memory(12U);
    memset(t1, 0, 12U);
    t4 = t1;
    memset(t4, (unsigned char)2, 12U);
    t5 = (t0 + 6352);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t1, 12U);
    xsi_driver_first_trans_fast_port(t5);
    xsi_set_current_line(96, ng0);
    t1 = xsi_get_transient_memory(4U);
    memset(t1, 0, 4U);
    t4 = t1;
    memset(t4, (unsigned char)2, 4U);
    t5 = (t0 + 6736);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t1, 4U);
    xsi_driver_first_trans_fast_port(t5);
    xsi_set_current_line(97, ng0);
    t1 = xsi_get_transient_memory(6U);
    memset(t1, 0, 6U);
    t4 = t1;
    memset(t4, (unsigned char)2, 6U);
    t5 = (t0 + 6800);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t1, 6U);
    xsi_driver_first_trans_fast_port(t5);
    xsi_set_current_line(98, ng0);
    t1 = xsi_get_transient_memory(5U);
    memset(t1, 0, 5U);
    t4 = t1;
    memset(t4, (unsigned char)2, 5U);
    t5 = (t0 + 6864);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t1, 5U);
    xsi_driver_first_trans_fast_port(t5);
    xsi_set_current_line(99, ng0);
    t1 = (t0 + 6416);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    *((unsigned char *)t14) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(100, ng0);
    t1 = (t0 + 6480);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    *((unsigned char *)t14) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(101, ng0);
    t1 = (t0 + 6672);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    *((unsigned char *)t14) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(102, ng0);
    t1 = (t0 + 6544);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    *((unsigned char *)t14) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(103, ng0);
    t1 = (t0 + 6608);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t10 = (t5 + 56U);
    t14 = *((char **)t10);
    *((unsigned char *)t14) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB5;

LAB35:;
}

static void work_a_0984964813_3212880686_p_3(char *t0)
{
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    int t9;
    char *t10;
    char *t11;
    int t12;
    char *t13;
    char *t14;
    int t15;
    char *t16;
    int t18;
    char *t19;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    static char *nl0[] = {&&LAB24, &&LAB24, &&LAB22, &&LAB23, &&LAB24, &&LAB24, &&LAB24, &&LAB24, &&LAB24};

LAB0:    xsi_set_current_line(120, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 6144);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(122, ng0);
    t3 = (t0 + 3592U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t6 = (t5 == (unsigned char)3);
    if (t6 != 0)
        goto LAB5;

LAB7:    t1 = (t0 + 3752U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t5 = (t2 == (unsigned char)3);
    if (t5 != 0)
        goto LAB19;

LAB20:    xsi_set_current_line(141, ng0);
    t1 = (t0 + 10591);
    t4 = (t0 + 6928);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t1, 3U);
    xsi_driver_first_trans_fast_port(t4);

LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(124, ng0);
    t3 = (t0 + 2152U);
    t7 = *((char **)t3);
    t3 = (t0 + 10559);
    t9 = xsi_mem_cmp(t3, t7, 2U);
    if (t9 == 1)
        goto LAB9;

LAB14:    t10 = (t0 + 10561);
    t12 = xsi_mem_cmp(t10, t7, 2U);
    if (t12 == 1)
        goto LAB10;

LAB15:    t13 = (t0 + 10563);
    t15 = xsi_mem_cmp(t13, t7, 2U);
    if (t15 == 1)
        goto LAB11;

LAB16:    t16 = (t0 + 10565);
    t18 = xsi_mem_cmp(t16, t7, 2U);
    if (t18 == 1)
        goto LAB12;

LAB17:
LAB13:    xsi_set_current_line(129, ng0);
    t1 = (t0 + 10579);
    t4 = (t0 + 6928);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t1, 3U);
    xsi_driver_first_trans_fast_port(t4);

LAB8:    goto LAB6;

LAB9:    xsi_set_current_line(125, ng0);
    t19 = (t0 + 10567);
    t21 = (t0 + 6928);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t19, 3U);
    xsi_driver_first_trans_fast_port(t21);
    goto LAB8;

LAB10:    xsi_set_current_line(126, ng0);
    t1 = (t0 + 10570);
    t4 = (t0 + 6928);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t1, 3U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB8;

LAB11:    xsi_set_current_line(127, ng0);
    t1 = (t0 + 10573);
    t4 = (t0 + 6928);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t1, 3U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB8;

LAB12:    xsi_set_current_line(128, ng0);
    t1 = (t0 + 10576);
    t4 = (t0 + 6928);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t1, 3U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB8;

LAB18:;
LAB19:    xsi_set_current_line(133, ng0);
    t1 = (t0 + 2792U);
    t4 = *((char **)t1);
    t1 = (t0 + 3272U);
    t7 = *((char **)t1);
    t9 = *((int *)t7);
    t12 = xsi_vhdl_mod(t9, 32);
    t15 = (t12 - 0);
    t26 = (t15 * 1);
    xsi_vhdl_check_range_of_index(0, 31, 1, t12);
    t27 = (1U * t26);
    t28 = (0 + t27);
    t1 = (t4 + t28);
    t6 = *((unsigned char *)t1);
    t8 = (t0 + 4048U);
    t10 = *((char **)t8);
    t8 = (t10 + 0);
    *((unsigned char *)t8) = t6;
    xsi_set_current_line(135, ng0);
    t1 = (t0 + 4048U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = (char *)((nl0) + t2);
    goto **((char **)t1);

LAB21:    goto LAB6;

LAB22:    xsi_set_current_line(136, ng0);
    t4 = (t0 + 10582);
    t8 = (t0 + 6928);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    t13 = (t11 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t4, 3U);
    xsi_driver_first_trans_fast_port(t8);
    goto LAB21;

LAB23:    xsi_set_current_line(137, ng0);
    t1 = (t0 + 10585);
    t4 = (t0 + 6928);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t1, 3U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB21;

LAB24:    xsi_set_current_line(138, ng0);
    t1 = (t0 + 10588);
    t4 = (t0 + 6928);
    t7 = (t4 + 56U);
    t8 = *((char **)t7);
    t10 = (t8 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t1, 3U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB21;

}


extern void work_a_0984964813_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0984964813_3212880686_p_0,(void *)work_a_0984964813_3212880686_p_1,(void *)work_a_0984964813_3212880686_p_2,(void *)work_a_0984964813_3212880686_p_3};
	xsi_register_didat("work_a_0984964813_3212880686", "isim/tb_grafika_isim_beh.exe.sim/work/a_0984964813_3212880686.didat");
	xsi_register_executes(pe);
}
