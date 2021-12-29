<template>
  <el-container>
     <el-header class="header"><v-head></v-head></el-header>
    <el-container>
      <el-aside width="auto">
        <el-menu class="navMenu" :router="true" unique-opened>
          <el-submenu index="1">
            <template slot="title"
              ><i class="el-icon-user"></i>管理操作</template
            >
            <el-menu-item-group>
              <el-menu-item index="/user">用户信息</el-menu-item>
              <el-menu-item index="/order">订单信息</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
        </el-menu>
      </el-aside>

      <el-main>
        <router-view></router-view>
      </el-main>
    </el-container>
    <el-footer> </el-footer>
  </el-container>
</template>

<style scoped>
.el-footer {
  background: gray;
}
.header{
  height: 60px;
}

.navMenu el-menu, .el-aside {
  min-width: 137px !important;
  overflow: hidden;
}
</style>

<script>
/* eslint-disable*/
// import aside from '../basic/aside'
// import footer from '../basic/footer'
// import header from '../basic/header'
// import main from '../basic/main'
 import vHead from '../basic/header.vue';
export default {
  name: "test",

       components: {
            vHead,

        },
};
</script>
