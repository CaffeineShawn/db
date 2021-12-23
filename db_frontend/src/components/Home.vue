<template>
  <el-container>
    <el-header>
      <header class="header">header</header>
    </el-header>
    <el-container>
      <el-aside>
        <aside class="aside">aside</aside>
      </el-aside>
      <el-main>
        <router-view></router-view>
      </el-main>

    </el-container>
    <el-footer>
    </el-footer>

  </el-container>
</template>

<style scoped>
.el-footer{
  background: gray;
}
</style>

<script>
/* eslint-disable*/
// import aside from '../basic/aside'
// import footer from '../basic/footer'
// import header from '../basic/header'
// import main from '../basic/main'

export default {
  name: 'test'
}
</script>