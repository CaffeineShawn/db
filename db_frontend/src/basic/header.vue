<template>
  <el-container>
    <div class="header" v-if="$route.meta.isBlank !== true">
      <!-- 折叠按钮 -->
      <div class="collapse-btn" @click="collapseChage">
        <i v-if="!collapse" class="el-icon-s-fold"></i>
        <i v-else class="el-icon-s-unfold"></i>
      </div>
      <div class="logo">物流管理系统</div>
      <div class="header-right">
        <div class="header-user-con">
          <!-- 用户头像 -->
          <div class="user-avator">
            <img src="../assets/3.jpg" />
          </div>
          <!-- 用户名下拉菜单 -->
          <el-dropdown
            class="user-name"
            trigger="click"
            @command="handleCommand"
          >
            <span class="el-dropdown-link">
              {{ this.$store.getters.getuser.user_name }}
              <i class="el-icon-caret-bottom"></i>
            </span>

            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item divided command="loginout"
                >退出登录</el-dropdown-item
              >
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </div>
    </div>
  </el-container>
</template>

<script>
export default {
  name: 'header',
  data () {
    return {
      user: {
        user_id: '',
        user_password: '',
        user_gender: '',
        user_phone: '',
        user_role: ''
      },
      changeform1: {
        username: '',
        password: ''
      },
      formLabelWidth: '100px',
      showuser1: false,
      collapse: false,
      fullscreen: false,
      name: ''
    }
  },
  computed: {
    username () {
      let username = sessionStorage.getItem('ms_username')
      return username || this.name
    }
  },
  methods: {
    // 用户名下拉菜单选择事件
    handleCommand (command) {
      if (command === 'loginout') {
        this.$store.getters.getuser.user_name = ''
        this.$store.getters.getuser.user_id = null
        this.$store.getters.getuser.user_gender = ''
        this.$store.getters.getuser.user_password = ''
        this.$store.getters.getuser.user_phone = ''
        this.$store.getters.getuser.user_role = null
        this.$router.push('/login')
      }
    },
    collapseChage () {
      this.collapse = !this.collapse
    }
  },
  mounted () {
    if (document.body.clientWidth < 1500) {
      this.collapseChage()
    }
  }
}
</script>

<style>
.header {
  position: relative;
  box-sizing: border-box;
  width: 100%;
  height: 60px;
  font-size: 22px;
  color: rgb(0, 0, 0);
}
.collapse-btn {
  float: left;
  padding: 0 21px;
  cursor: pointer;
  line-height: 70px;
}
.header .logo {
  float: left;
  width: 250px;
  line-height: 70px;
}
.header-right {
  float: right;
  height: 60px;
  padding-right: 50px;
}
.header-user-con {
  display: flex;
  height: 60px;
  align-items: center;
  margin: 0;
  padding: 0;
}
.btn-fullscreen {
  transform: rotate(45deg);
  margin-right: 5px;
  font-size: 24px;
}
.btn-bell,
.btn-fullscreen {
  position: relative;
  width: 30px;
  height: 30px;
  text-align: center;
  border-radius: 15px;
  cursor: pointer;
}
.btn-bell-badge {
  position: absolute;
  right: 0;
  top: -2px;
  width: 8px;
  height: 8px;
  border-radius: 4px;
  background: #f56c6c;
  color: #fff;
}
.btn-bell .el-icon-bell {
  color: #fff;
}
.user-name {
  margin-left: 10px;
}
.user-avator {
  margin-left: 20px;
}
.user-avator img {
  display: block;
  width: 40px;
  height: 40px;
  border-radius: 50%;
}
.el-dropdown-link {
  color: rgb(0, 0, 0);
  cursor: pointer;
}
.el-dropdown-menu__item {
  text-align: center;
}
</style>
