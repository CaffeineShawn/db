<template>
  <div class="login-container">
    <div class="ms-login">
      <div class="ms-title">考试系统</div>
      <el-form
        ref="form"
        :model="loginform"
        label-width="0px"
        class="ms-content"
      >
        <el-form-item prop="username">
          <el-input placeholder="username" v-model="loginform.username">
            <el-button slot="prepend" icon="el-icon-user-solid"></el-button>
          </el-input>
        </el-form-item>

        <el-form-item prop="password">
          <el-input
            type="password"
            placeholder="password"
            v-model="loginform.password"
          >
            <el-button slot="prepend" icon="el-icon-lock"></el-button>
          </el-input>
        </el-form-item>

        <div class="login-btn">
          <el-button type="primary" @click="login">登录</el-button>
        </div>
        <div class="login-btn">
          <el-button plain @click="dialogFormVisible = true">注册</el-button>
        </div>
      </el-form>
    </div>

    <el-dialog
      title="用户注册"
      :visible.sync="dialogFormVisible"
      center
      width="20%"
      :destroy-on-close="true"
    >
      <el-form ref="form" :model="registerform">
        <el-form-item label="用户名" label-width="80px" prop="userName">
          <el-input
            v-model="registerform.username"
            :label-width="formLabelWidth"
            placeholder="username"
            style="width: auto"
          ></el-input>
        </el-form-item>
        <el-form-item label="密码" label-width="80px" prop="password">
          <el-input
            type="password"
            v-model="registerform.password"
            :label-width="formLabelWidth"
            placeholder="password"
            style="width: auto"
          ></el-input>
        </el-form-item>
        <el-form-item label="电话号码" label-width="80px" prop="phone">
          <el-input
            v-model="registerform.phone"
            :label-width="formLabelWidth"
            placeholder="phone"
            style="width: auto"
          ></el-input>
        </el-form-item>
        <el-form-item label="性别" label-width="80px" prop="form">
          <el-select
            v-model="registerform.role"
            placeholder="gender"
            :label-width="formLabelWidth"
            style="width: auto"
            @change="selectType"
          >
            <el-option label="男" value="man"></el-option>
            <el-option label="女" value="woman"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="resetForm('form')">取 消</el-button>
        <el-button type="primary" @click="register">注 册</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: 'Login',
  props: {
    msg: String
  },
  data () {
    return {
      showlogin: true,
      loginform: {
        username: 'as',
        password: '1234',
        region: ''
      },
      registerform: {
        username: '',
        password: '',
        phone: '',
        role: ''
      },
      dialogFormVisible: false,
      formLabelWidth: '100px'
    }
  },
  methods: {
    selectType (event) {
      console.log(event)
      this.status = event
    },
    async login () {
      // 获取用户登录数据
      let user = {
        user_name: this.loginform.username,
        user_password: this.loginform.password
      }
      // 校验
      await this.$http.post('/user/login', user).then(res => {
        console.log('detail', res)
        if (res.data > 0) {
          this.$message({
            message: '登录成功',
            type: 'success'
          })
          this.$store.commit('setuser', res.data)
          this.$router.push('/home')
        } else {
          this.$message({
            message: '登录失败',
            type: 'error'
          })
        }
      })
    },
    async register () {
      // 获取用户注册数据
      let user = {
        user_name: this.registerform.username,
        user_password: this.registerform.password,
        user_phone: this.registerform.phone,
        user_gender: this.registerform.role
      }
      console.log(user)
      // 校验
      // 发送请求
      await this.$http.post('/user/addUser', user).then(res => {
        this.$message({
          message: '注册成功',
          type: 'success'
        })
        console.log(res)
      })
      this.dialogFormVisible = false
    },
    resetForm (form) {
      this.$refs[form].resetFields()
      this.dialogFormVisible = false
    }
  }
}
</script>

<style scoped>
.login-container {
  position: relative;
  width: 100%;
  height: 100%;
  background: url(../assets/1.png);
  background-size: 100% 100%;
}

.ms-title {
  width: 100%;
  line-height: 50px;
  text-align: center;
  font-size: 20px;
  color: rgb(56, 83, 114);
  border-bottom: 1px solid #ddd;
}
.ms-content {
  padding: 30px 30px;
}

.ms-login {
  position: absolute;
  left: 50%;
  top: 50%;
  width: 350px;
  margin: -190px 0 0 -175px;
  border-radius: 5px;
  background: rgba(255, 255, 255, 0.3);
  overflow: hidden;
}

.login-btn {
  text-align: center;
}

.login-btn button {
  width: 50%;
  height: 36px;
  margin-bottom: 10px;
}
</style>
